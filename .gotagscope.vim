
"-----------------------------------------------------------------------------------------------------
" 현재 열려 있는 파일이 어떤 프로젝트 폴더에 있는지 확인하고, 해당 폴더의 전용 태그와 cscope만 로드"
" 디버깅을 위해 s: 를 빼고 전역 함수로 변경했습니다.

" [주의사항] 최초 실행 시 프로젝트 루트를 찾기 위해 .git 폴더나 cscope.out 파일이 필요합니다.
" 빈 폴더에서 새로 시작할 때는 터미널에서 'git init' 또는 'cscope -b'를 한 번 실행해 주세요.
"-----------------------------------------------------------------------------------------------------

" ---------------------------------------------------------
" 1. 프로젝트 루트를 찾는 가장 확실한 함수
" ---------------------------------------------------------
function! s:GetProjectRoot()
    let l:curr_dir = expand('%:p:h')
    
    " 최우선: cscope.out 파일 자체가 있는 곳을 찾아 거기를 루트로 확정!
    " (Git이 아니어도 cscope.out만 있으면 작동하게 하는 가장 강력한 방식)
    let l:cs_file = findfile('cscope.out', l:curr_dir . ';')
    if !empty(l:cs_file)
        return fnamemodify(l:cs_file, ':p:h')
    endif
    
    " 차선책: cscope.out이 안 보이면 .git 폴더 기준 탐색
    let l:git_dir = finddir('.git', l:curr_dir . ';')
    if !empty(l:git_dir)
        return fnamemodify(l:git_dir, ':p:h')
    endif
    
    return ''
endfunction

" ---------------------------------------------------------
" 2. 루트를 기반으로 태그와 Cscope를 세팅하는 함수
" ---------------------------------------------------------
function! SetupProjectEnv()
    let l:project_root = s:GetProjectRoot()
    if empty(l:project_root)
        return
    endif

    " [NEW] 3. 일반 ctags 설정 (C/C++ 등을 위한 기본 태그)
    let l:ctags_path = l:project_root . '/tags'
    if filereadable(l:ctags_path)
        if stridx(&tags, l:ctags_path) == -1
            let &tags = l:ctags_path . "," . &tags
        endif
    endif

    " 4. gotags 설정 (절대 경로 보장)
    let l:tag_path = l:project_root . '/gotags'
    if filereadable(l:tag_path)
        if stridx(&tags, l:tag_path) == -1
            let &tags = l:tag_path . "," . &tags
        endif
    endif

    " 5. cscope 설정 (핵심 수정 사항 ★★★)
    let l:cs_path = l:project_root . '/cscope.out'
    if filereadable(l:cs_path)
        " 기존 연결 무조건 끊기 (경로 꼬임 원천 차단)
        silent! execute 'cs kill ' . fnameescape(l:cs_path)
        
        " [중요] cs add {데이터베이스경로} {기준경로}
        " 하위 폴더에서 열었을 때 cscope 내부의 상대 경로들이 깨지지 않도록
        " 두 번째 파라미터로 '프로젝트 루트(기준 경로)'를 명시적으로 던져줍니다.
        silent! execute 'cs add ' . fnameescape(l:cs_path) . ' ' . fnameescape(l:project_root)
    endif
endfunction

" ---------------------------------------------------------
" 6. 자동 실행 및 매핑
" ---------------------------------------------------------
augroup project_env_auto
    autocmd!
    autocmd BufEnter * call SetupProjectEnv()
augroup END

nnoremap <leader>l <C-]>
nnoremap <leader>h <C-T>



" ---------------------------------------------------------
" 7. 커스텀 태그 업데이트 자동화 (make_gotags.sh 연동 또는 내장 디폴트)
" ---------------------------------------------------------

" [NEW] 내장 디폴트 태그 생성 함수 (make_gotags.sh가 없을 때 실행됨)
function! s:GenerateTagsDefault(root, include_tests)
    let l:cmd = 'cd ' . shellescape(a:root) . ' && '
    
    if a:include_tests
        " _test.go 포함 로직
        let l:cmd .= "find . -type f -name '*.go' | gotags -f gotags -L - && "
        let l:cmd .= "find . -type f \\( -name '*.go' -o -name '*.c' -o -name '*.h' \\) > cscope.files && "
        let l:cmd .= "ctags -R --exclude=.git --exclude=vendor . && "
    else
        " _test.go 제외 로직
        let l:cmd .= "find . -type f -name '*.go' ! -name '*_test.go' | gotags -f gotags -L - && "
        let l:cmd .= "find . -type f \\( \\( -name '*.go' ! -name '*_test.go' \\) -o -name '*.c' -o -name '*.h' \\) > cscope.files && "
        let l:cmd .= "ctags -R --exclude=.git --exclude=vendor --exclude='*_test.go' . && "
    endif
    
    " 마지막으로 cscope 데이터베이스 생성
    " [수정됨] 화면 겹침 방지를 위해 모든 출력을 /dev/null로 버림"
    let l:cmd .= "cscope -bvq > /dev/null 2>&1"
    
    " 백그라운드에서 조용히 실행
    execute 'silent !' . l:cmd
endfunction

function! UpdateProjectTags(include_tests, is_auto)
    let l:root = s:GetProjectRoot()
    if empty(l:root)
        return
    endif

    let l:custom_script = l:root . '/make_gotags.sh'
    let l:run_mode = ""
    
    " (1) 커스텀 스크립트가 있으면 그것을 실행, 없으면 내장 디폴트 로직 실행
    if filereadable(l:custom_script)
        let l:opt = a:include_tests ? " -t" : ""
        " [수정됨] 커스텀 스크립트 실행 시에도 모든 출력을 /dev/null로 버림
        execute 'silent !cd ' . shellescape(l:root) . ' && ./make_gotags.sh' . l:opt . ' > /dev/null 2>&1'
        let l:run_mode = "(Custom Script)"
    else
        call s:GenerateTagsDefault(l:root, a:include_tests)
        let l:run_mode = "(Built-in Default)"
    endif

    " (2) 완료 후 기존 SetupProjectEnv()를 재호출하여 cscope.out과 tags 리셋/재연결
    call SetupProjectEnv()

    " [핵심 수정] 자동 저장(is_auto)이든 수동이든 쉘 실행 후에는 무조건 화면을 다시 그림!
    redraw!
    
    " (3) 수동 실행 시에만 완료 메시지 출력 (어떤 방식으로 실행되었는지도 표시)
    if !a:is_auto
        if a:include_tests
            echo "Tags updated (including _test.go) " . l:run_mode . " & cscope reset successful!"
        else
            echo "Tags updated (excluding _test.go) " . l:run_mode . " & cscope reset successful!"
        endif
    endif
endfunction

" 수동 실행용 커스텀 명령어 (메시지 O)
command! MakeTags call UpdateProjectTags(0, 0)
command! MakeTagsTest call UpdateProjectTags(1, 0)

" ---------------------------------------------------------
" 8. 파일 저장 시 자동 갱신 (기본: _test.go 제외, 메시지 X)
" ---------------------------------------------------------
augroup AutoUpdateTagsOnSave
    autocmd!
    " .go, .c, .h 파일을 저장할 때마다 조용히 갱신
    autocmd BufWritePost *.go,*.c,*.h call UpdateProjectTags(0, 1)
augroup END
