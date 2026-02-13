" 파일명: ~/.gopls.vim
" 목적: vim-go 및 gopls(Language Server) 최적화 설정

" 1. vim-go의 기본 단축키 매핑 비활성화 (우리가 직접 커스텀하기 위함)
let g:go_def_mapping_enabled = 0
let g:go_doc_keywordprg_enabled = 0
let g:go_textobj_enabled = 0

" 2. 정의 이동(Def)과 정보 보기(Info)의 핵심 엔진을 gopls로 강제 지정
let g:go_def_mode = 'gopls'
let g:go_info_mode = 'gopls'

" 3. 자동 완성 및 UI 최적화
" 함수나 변수 위에 커서를 0.5초(500ms) 올리면 하단 상태창에 타입 정보 표시
let g:go_auto_type_info = 1
let g:go_updatetime = 500

" 4. 저장 시 자동화 (초강력 추천)
" 저장할 때마다 자동으로 코드 포맷을 맞추고, 쓰지 않는 import를 지우거나 추가함
let g:go_fmt_command = "goimports"

" 5. 실시간 에러/경고 표시 (Diagnostics)
let g:go_diagnostics_enabled = 1
let g:go_diagnostics_level = 2 " 에러와 경고 모두 표시
let g:go_metalinter_autosave = 1 " 저장 시 linter(golangci-lint) 백그라운드 실행
