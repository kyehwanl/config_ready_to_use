
"-----------------------------------------------------------------------------------------------------
" 현재 열려 있는 파일이 어떤 프로젝트 폴더에 있는지 확인하고, 해당 폴더의 전용 태그와 cscope만 로드"
" 디버깅을 위해 s: 를 빼고 전역 함수로 변경했습니다.
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

    " 3. gotags 설정 (절대 경로 보장)
    let l:tag_path = l:project_root . '/gotags'
    if filereadable(l:tag_path)
        if stridx(&tags, l:tag_path) == -1
            let &tags = l:tag_path . "," . &tags
        endif
    endif

    " 4. cscope 설정 (핵심 수정 사항 ★★★)
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
" 3. 자동 실행 및 매핑
" ---------------------------------------------------------
augroup project_env_auto
    autocmd!
    autocmd BufEnter * call SetupProjectEnv()
augroup END

nnoremap <leader>l <C-]>
nnoremap <leader>h <C-T>
