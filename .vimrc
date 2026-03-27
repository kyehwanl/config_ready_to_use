" An example for a vimrc file {

" =========================================================
"  Language Support
" =========================================================
set encoding=utf-8
set fileencodings=utf-8,cp949,euc-kr
set termencoding=utf-8


" =========================================================
"  Gloabal Variables
" =========================================================
let g:spf13_no_autochdir = 1
let g:spf13_no_views = 1
let g:go_jump_to_error = 0 " do not jump when error found in saving time"
let g:go_list_autowindow = 0 "Quickfix 창이 자동으로 열리는 것도 끄고 싶다면

"
" Maintainer:   Bram Moolenaar <Bram@vim.org>
" Last change:  2006 Aug 12
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"         for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"       for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup      " do not keep a backup file, use versions instead
else
  set backup        " keep a backup file
endif
set nobackup 
set nowritebackup
set history=50      " keep 50 lines of command line history
set ruler       " show the cursor position all the time
set showcmd     " display incomplete commands
set incsearch       " do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" In an xterm the mouse should work quite well, thus enable it.
"set mouse=a

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

  augroup filetypedetect
      au BufRead,BufNewFile *.p4 setfiletype c
      " associate *.p4 with c filetype
  augroup END 

else

  set autoindent        " always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
        \ | wincmd p | diffthis

" }

" General  {
"
"------------------------ LKH additional setting --------------------
"set tags=./tags,../tags,../../tags,/usr/tags
"set tags+=/root/linux/tags
"set tags+=/root/linux/include/linux/tags " kernel
"set tags+=/usr/include/tags     " include 
""set tags+=./tags;/,~/.vimtags
""set tags+=./gotags,../gotags,../../gotags

set shiftwidth=4
set tabstop=8
set softtabstop=4
"set textwidth=79
set smartindent
set cindent
"set nowrap
colorscheme torte
"set background=dark
hi clear
set showmatch
set splitright   " Puts new vsplit windows to the right of the current"
set splitbelow   " Puts new split windows to the bottom of the current"


inoremap <ESC> <ESC>:set imdisable<CR>
nnoremap i :set noimd<CR>i
nnoremap I :set noimd<CR>I
nnoremap a :set noimd<CR>a
nnoremap A :set noimd<CR>A
nnoremap o :set noimd<CR>o
nnoremap O :set noimd<CR>O


" --- tag directly withough selection among multiple selections
" nnoremap <c-]> g<c-]>
" vnoremap <c-]> g<c-]>

" --- tag and pop do more easily
"nnoremap <leader>h <C-T>
"nnoremap <leader>l <C-]>
" --- changed to recursive mapping (instead of nnoremap) for vim-go
nmap <leader>h <C-T>
nmap <leader>l <C-]>

" --- Open the definition in a vertical split (ex. ctrl-W ctrl-]:  horizontal split)
map <leader>] :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

map <F1> v%zf
"map <F4> :e %:p:s,.h$,.X123X,:s,.cc$,.h,:s,.X123X$,.cc,<CR> ".h <--> .cc exchange
map <F3> :e %:p:s,.h$,.X123X,:s,.c$,.h,:s,.X123X$,.c,<CR>
map <leader>H :e %:p:s,.h$,.X123X,:s,.c$,.h,:s,.X123X$,.c,<CR>
map ,H :e %:p:s,.h$,.X123X,:s,.c$,.h,:s,.X123X$,.c,<CR>

map <F4> :cn<CR>
map <F7> :make<CR>
map <F5> :!./%<<CR>
map <F2> :Tlist<cr><C-W><C-W>
map <PageUp> <C-U><C-U>
map <PageDown> <C-D><C-D>
"map <F6> :find ./ -name '*.[ch]' > cscope.files<CR> <-- i don't know how to

"move onto the Nth file buffer. (cf) :ls or :files
map ,1 :b!1<CR>
map ,2 :b!2<CR>
map ,3 :b!3<CR>
map ,4 :b!4<CR>
map ,5 :b!5<CR>
map ,6 :b!6<CR>
map ,7 :b!7<CR>
map ,8 :b!8<CR>
map ,9 :b!9<CR>

" maximize screen and same size
map ,- <C-W>_
map ,= <C-W>=
"map ,\ <C-W>|<CR>

" ------- goto first point, last point in a line -----
"nnoremap <C-H> ^
"nnoremap <C-L> $
" confer this--> Shift-H Shift-L:

"man page user function
func! Man()
    let sm = expand("<cword>")
    exe "!man -S 2:3:4:5:6:7:8:9:tcl:n:l:p:o ".sm
endfunc
nmap ,ma :call Man()<cr><cr>


" -------- move among windows ---------------
nmap <C-H> <C-W>h 
nmap <C-J> <C-W>j 
nmap <C-K> <C-W>k 
nmap <C-L> <C-W>l 

" -------- Search for Visually Selected Text" ------
vnorem // y/<c-r>"<cr>

" }

" Cscope Option {
"
"----------- cscope option ---------------------
"set csprg=/usr/bin/cscope
"set csto=0
"set cst
"set nocst

"---------no cscope message displayed
"set nocsverb 

if filereadable("./cscope.out")
"   cs add cscope.out
else
"   cs add /usr/src/linux/cscope.out
"   cs add /usr/local/lkh_prog/cscope.out 
    " --> it works !!
"   cs add ../cscope.out 
endif
"set csverb

" -----------------------------------------------------------------------------
"  LKH_COMMENTS : 
"
"  when you make cscope.files, use the ABSOLUTE path 
"       find /usr/local/lkh_prog/NIST_ID_LOC/ -name '*.[ch]' > cscope.files
"       cscope -b ( implements without starting cscope GUI
"
"  and also, you can use CSCOPE_DB env variable in .bash_profile or .bashrc
"       CSCOPE_DB=/usr/local/lkh_prog/cscope.out
"       export CSCOPE_DB
" -----------------------------------------------------------------------------

if has("cscope")

	""""""""""""" Standard cscope/vim boilerplate

    " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    set cscopetag

    " check cscope for definition of a symbol before checking ctags: set to 1
    " if you want the reverse search order.
    "set csto=0

    " add any cscope database in current directory
    if filereadable("cscope.out")
        " LKH_comment cs add cscope.out  
    " else add the database pointed to by environment variable 
    elseif $CSCOPE_DB != ""
        ""cs add $CSCOPE_DB
    endif

    " show msg when any other cscope db added
    set cscopeverbose


    """"""""""""" My cscope/vim key mappings
    "
    " The following maps all invoke one of the following cscope search types:
    "
    "   's'   symbol: find all references to the token under cursor
    "   'g'   global: find global definition(s) of the token under cursor
    "   'c'   calls:  find all calls to the function name under cursor
    "   't'   text:   find all instances of the text under cursor
    "   'e'   egrep:  egrep search for the word under cursor
    "   'f'   file:   open the filename under cursor
    "   'i'   includes: find files that include the filename under cursor
    "   'd'   called: find functions that function under cursor calls
    "
    
    " To do the first type of search, hit 'CTRL-\', followed by one of the
    " cscope search types above (s,g,c,t,e,f,i,d).  The result of your cscope
    " search will be displayed in the current window.  You can use CTRL-T to
    " go back to where you were before the search.  
    "

    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR> 
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR> 
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR> 
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR> 
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR> 
    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR> 
    nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR> 


    " Using 'CTRL-spacebar' (intepreted as CTRL-@ by vim) then a search type
    " makes the vim window split horizontally, with search result displayed in
    " the new window.
    "
    " (Note: earlier versions of vim may not have the :scs command, but it
    " can be simulated roughly via:
    "    nmap <C-@>s <C-W><C-S> :cs find s <C-R>=expand("<cword>")<CR><CR>  

    nmap <C-@>s :scs find s <C-R>=expand("<cword>")<CR><CR>    
    nmap <C-@>g :scs find g <C-R>=expand("<cword>")<CR><CR>    
    nmap <C-@>c :scs find c <C-R>=expand("<cword>")<CR><CR>    
    nmap <C-@>t :scs find t <C-R>=expand("<cword>")<CR><CR>    
    nmap <C-@>e :scs find e <C-R>=expand("<cword>")<CR><CR>    
    nmap <C-@>f :scs find f <C-R>=expand("<cfile>")<CR><CR>    
    nmap <C-@>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>  
    nmap <C-@>d :scs find d <C-R>=expand("<cword>")<CR><CR>    


	" Hitting CTRL-space *twice* before the search type does a vertical 
    " split instead of a horizontal one (vim 6 and up only)
    "
    " (Note: you may wish to put a 'set splitright' in your .vimrc
    " if you prefer the new window on the right instead of the left

    nmap <C-@><C-@>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-@><C-@>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-@><C-@>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>


    """"""""""""" key map timeouts
    "
    " By default Vim will only wait 1 second for each keystroke in a mapping.
    " You may find that too short with the above typemaps.  If so, you should
    " either turn off mapping timeouts via 'notimeout'.
    "
    "set notimeout 
    "
    " Or, you can keep timeouts, by uncommenting the timeoutlen line below,
    " with your own personal favorite value (in milliseconds):
    "
    "set timeoutlen=4000
    "
    " Either way, since mapping timeout settings by default also set the
    " timeouts for multicharacter 'keys codes' (like <F1>), you should also
    " set ttimeout and ttimeoutlen: otherwise, you will experience strange
    " delays as vim waits for a keystroke after you hit ESC (it will be
    " waiting to see if the ESC is actually part of a key code like <F1>).
    "
    "set ttimeout 
    "
    " personally, I find a tenth of a second to work well for key code
    " timeouts. If you experience problems and have a slow terminal or network
    " connection, set it higher.  If you don't set ttimeoutlen, the value for
    " timeoutlent (default: 1000 = 1 second, which is sluggish) is used.
    "
    "set ttimeoutlen=100
endif
"============================================================================

" }

"  Source Explorer {

" // The switch of the Source Explorer 
"nmap <F8> :SrcExplToggle<CR> 

" // Set the height of Source Explorer window 
let g:SrcExpl_winHeight = 8 

" // Set 100 ms for refreshing the Source Explorer 
let g:SrcExpl_refreshTime = 100 

" // Set "Enter" key to jump into the exact definition context 
let g:SrcExpl_jumpKey = "<ENTER>" 

" // Set "Space" key for back from the definition context 
let g:SrcExpl_gobackKey = "<SPACE>" 

" // In order to Avoid conflicts, the Source Explorer should know what plugins 
" // are using buffers. And you need add their bufname into the list below 
" // according to the command ":buffers!" 
let g:SrcExpl_pluginList = [ 
        \ "__Tag_List__", 
        \ "_NERD_tree_", 
        \ "Source_Explorer" 
    \ ] 

" // Enable/Disable the local definition searching, and note that this is not 
" // guaranteed to work, the Source Explorer doesn't check the syntax for now. 
" // It only searches for a match with the keyword according to command 'gd' 
let g:SrcExpl_searchLocalDef = 1 

" // Do not let the Source Explorer update the tags file when opening 
let g:SrcExpl_isUpdateTags = 0 

" // Use 'Exuberant Ctags' with '--sort=foldcase -R .' or '-L cscope.files' to 
" //  create/update a tags file 
let g:SrcExpl_updateTagsCmd = "ctags --sort=foldcase -R ." 

" // Set "<F12>" key for updating the tags file artificially 
let g:SrcExpl_updateTagsKey = "<F12>" 

" }

" Trinity.vim {

" Open and close all the three plugins on the same time 
nmap <F8>   :TrinityToggleAll<CR> 

" Open and close the srcexpl.vim separately 
"nmap <F9>   :TrinityToggleSourceExplorer<CR> :set hlsearch<CR>
nmap <F9>   :TrinityToggleSourceExplorer<CR>

" Open and close the taglist.vim separately 
nmap <F10>  :TrinityToggleTagList<CR> 
"nmap <F10>  :TagList<CR> 
"nmap <F10>  :Tlist<CR> 

" Open and close the NERD_tree.vim separately 
nmap <F11>  :TrinityToggleNERDTree<CR> 

" }

" pathogen {
"

"call pathogen#runtime_append_all_bundles()
"call pathogen#helptags()

" }

" Folder Setting {
"--------------------------------------------------
"   when vim starts, do ":mkview"
"   when vim leaves, do ":loadview"
"
"    ":mkview"   : save the folds 
"    ":loadview" : reload the previous folds status
"
if argc() > 0
"    au BufWinLeave * mkview
"    au BufWinEnter * silent loadview

    "set foldmethod=indent
    set foldmethod=marker
    set foldlevelstart=99
    set foldmarker={{{,}}}
    "set foldmethod=manual
endif
    
"set foldmethod=marker
"
" }

" Aabbreviation { 
"
abbr #b /*****
abbr #c *****/

" }

" Change font size quickly {
let s:pattern = '^\(.* \)\([1-9][0-9]*\)$'
let s:minfontsize = 6
let s:maxfontsize = 16
function! AdjustFontSize(amount)
  if has("gui_gtk2") && has("gui_running")
    let fontname = substitute(&guifont, s:pattern, '\1', '')
    let cursize = substitute(&guifont, s:pattern, '\2', '')
    let newsize = cursize + a:amount
    if (newsize >= s:minfontsize) && (newsize <= s:maxfontsize)
      let newfont = fontname . newsize
      let &guifont = newfont
    endif
  else
    echoerr "You need to run the GTK2 version of Vim to use this function."
  endif
endfunction

function! LargerFont()
  call AdjustFontSize(1)
endfunction
command! LargerFont call LargerFont()

function! SmallerFont()
  call AdjustFontSize(-1)
endfunction
command! SmallerFont call SmallerFont()

"--------------------------------------------------
" }

" Modeline and Notes {
" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker spell:
"
"                    __ _ _____              _
"         ___ _ __  / _/ |___ /      __   __(_)_ __ ___
"        / __| '_ \| |_| | |_ \ _____\ \ / /| | '_ ` _ \
"        \__ \ |_) |  _| |___) |_____|\ V / | | | | | | |
"        |___/ .__/|_| |_|____/        \_/  |_|_| |_| |_|
"            |_|
"
"   This is the personal .vimrc file of Steve Francia.
"   While much of it is beneficial for general use, I would
"   recommend picking out the parts you want and understand.
"
"   You can find me at http://spf13.com
" }     

" Environment {

    " Basics {
        set nocompatible        " Must be first line                                                                  
    " }

    " Windows Compatible {
        " On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
        " across (heterogeneous) systems easier.
        if has('win32') || has('win64')
          set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
        endif
    " }

    " Setup Bundle Support {
        " The next three lines ensure that the ~/.vim/bundle/ system works
        filetype on
        filetype off
        " ---- Vundle Renewal --- 
        " 1. rm -rf ~/.vim/bundle/Vundle.vim
        " 2. git clone https://github.com/VundleVim/Vundle.vim.git  ~/.vim/bundle/Vundle.vim
        " 3. BundleInstall and BundleClean
        set rtp+=~/.vim/bundle/Vundle.vim
        call vundle#rc()
    " }

" }

" Bundles {

    " Use local bundles if available {
        if filereadable(expand("~/.vimrc.bundles.local"))
            source ~/.vimrc.bundles.local
        endif
    " }

    " Use fork bundles if available {
        if filereadable(expand("~/.vimrc.bundles.fork"))
            source ~/.vimrc.bundles.fork
        endif
    " }

    " Use bundles config {
        if filereadable(expand("~/.vimrc.bundles"))
            "source ~/.vimrc.bundles
        endif
    " }

    Bundle 'VundleVim/Vundle.vim'
    Bundle 'mbbill/undotree'
    "Bundle 'Shougo/neocomplcache' --> DO NOT install, conflict with vim-go
    "Bundle 'Shougo/neosnippet'    --> DO NOT install, conflict with vim-go
    ""Bundle 'honza/vim-snippets'  --> no longer use, auto complete
    Bundle 'vim-scripts/restore_view.vim'
    "Bundle 'scrooloose/syntastic' --> DO NOT install, conflict with vim-go
    Bundle 'godlygeek/tabular'
    Bundle 'spf13/vim-autoclose'

    Bundle 'easymotion/vim-easymotion'  
    Bundle 'tpope/vim-fugitive'
    Bundle 'ctrlpvim/ctrlp.vim' 

    Bundle 'klen/python-mode'
    Bundle 'python.vim'
    Bundle 'python_match.vim'
    Bundle 'pythoncomplete'

    Bundle 'fatih/vim-go'
    Bundle 'vim-airline/vim-airline' 
    Bundle 'preservim/tagbar'
    "Bundle 'nathanaelkane/vim-indent-guides' and then BundleInstall --> not my favor
    " coc.nvim 설치 (release 브랜치 사용)
    Bundle 'neoclide/coc.nvim', {'branch': 'release'}

" }

" General {
                                                                                                                      
    set background=dark         " Assume a dark background
    if !has('gui')
        "set term=$TERM          " Make arrow and other keys work
    endif
    filetype plugin indent on   " Automatically detect file types.
    syntax on                   " Syntax highlighting
    "set mouse=a                 " Automatically enable mouse usage
    "set mousehide               " Hide the mouse cursor while typing
    scriptencoding utf-8

    if has ('x') && has ('gui') " On Linux use + register for copy-paste
        set clipboard=unnamedplus
    elseif has ('gui')          " On mac and Windows, use * register for copy-paste
        set clipboard=unnamed
    endif

    " Most prefer to automatically switch to the current file directory when
    " a new buffer is opened; to prevent this behavior, add the following to
    " your .vimrc.bundles.local file:
    let g:spf13_no_autochdir = 1
    if !exists('g:spf13_no_autochdir')
        autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
        " Always switch to the current file directory
    endif

    "set autowrite                       " Automatically write a file when leaving a modified buffer
    set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
    "set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
    set viewoptions=folds,cursor,unix,slash " Better Unix / Windows compatibility, 
                                            "   where 'option (for buffer-local mappings and local setting) --> now removed'
    set virtualedit=onemore             " Allow for cursor beyond last character
    set history=1000                    " Store a ton of history (default is 20)
    "set spell                           " Spell checking on
    set hidden                          " Allow buffer switching without saving

    " Setting up the directories {
        set backup                  " Backups are nice ...
        if has('persistent_undo')
            set undofile                " So is persistent undo ...
            set undolevels=1000         " Maximum number of changes that can be undone
            set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
        endif

        " To disable views add the following to your .vimrc.bundles.local file:
        let g:spf13_no_views = 1
        if !exists('g:spf13_no_views')
            " Add exclusions to mkview and loadview
            " eg: *.*, svn-commit.tmp
            let g:skipview_files = [
                \ '\[example pattern\]'
                \ ]
        endif
    " }

" }

" Vim UI {

    if filereadable(expand("~/.vim/bundle/vim-colorschemes/colors/solarized.vim"))
        let g:solarized_termcolors=256
        ""color solarized                 " Load a colorscheme
	colorscheme solarized 
    endif
        let g:solarized_termtrans=1
        let g:solarized_contrast="high"
        let g:solarized_visibility="high"
    set tabpagemax=15               " Only show 15 tabs
    set showmode                    " Display the current mode

    set cursorline                  " Highlight current line

    if has('cmdline_info')
        set ruler                   " Show the ruler
        "set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
        set showcmd                 " Show partial commands in status line and
                                    " Selected characters/lines in visual mode
    endif

    "if has('statusline')
    	"set laststatus=2

    	" Broken down into easily includeable segments
    	"set statusline=%<%f\                     " Filename
    	"set statusline+=%w%h%m%r                 " Options
    	"set statusline+=%{fugitive#statusline()} " Git Hotness
    	"set statusline+=\ [%{&ff}/%Y]            " Filetype
    	"set statusline+=\ [%{getcwd()}]          " Current dir
    	"set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
    "endif

    set backspace=indent,eol,start  " Backspace for dummies
    set linespace=0                 " No extra spaces between rows
    "set nu                          " Line numbers on
    set showmatch                   " Show matching brackets/parenthesis
    set incsearch                   " Find as you type search
    set hlsearch                    " Highlight search terms
    set winminheight=0              " Windows can be 0 line high
    set ignorecase                  " Case insensitive search
    set smartcase                   " Case sensitive when uc present
    set wildmenu                    " Show list instead of just completing
    set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap to
    "set scrolljump=5                " Lines to scroll when cursor leaves screen
    "set scrolloff=3                 " Minimum lines to keep above and below cursor
    set foldenable                  " Auto fold code
    set list
    set listchars=tab:,.,trail:.,extends:#,nbsp:. " Highlight problematic whitespace
    set nolist

" }

" Formatting {

    set nowrap                      " Wrap long lines
    set autoindent                  " Indent at the same level of the previous line
    set shiftwidth=2                " (sw) Use indents of 4 spaces
    set expandtab                   " Tabs are spaces, not tabs
    set tabstop=4                   " (ts) An indentation every four columns                                               
    set softtabstop=4               " (sts) Let backspace delete indent
    "set matchpairs+=<:>             " Match, to be used with %
    set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
    "set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
    " Remove trailing whitespaces and ^M chars
    autocmd FileType c,cpp,java,php,javascript,python,twig,xml,yml autocmd BufWritePre <buffer> call StripTrailingWhitespace()
    autocmd BufNewFile,BufRead *.html.twig set filetype=html.twig

" }

" Key (re)Mappings {

    " The default leader is '\', but many people prefer ',' as it's in a standard
    " location. To override this behavior and set it back to '\' (or any other
    " character) add the following to your .vimrc.bundles.local file:
    "   let g:spf13_leader='\'
    if !exists('g:spf13_leader')
        let mapleader = ','
    else
        let mapleader=g:spf13_leader
    endif

    " Easier moving in tabs and windows
    "map <C-J> <C-W>j<C-W>_
    "map <C-K> <C-W>k<C-W>_
    "map <C-L> <C-W>l<C-W>_
    "map <C-H> <C-W>h<C-W>_

    " Wrapped lines goes down/up to next row, rather than next line in file.
    nnoremap j gj
    nnoremap k gk

    " Yank from the cursor to the end of the line, to be consistent with C and D.
    nnoremap Y y$

    " Code folding options
    nmap <leader>f0 :set foldlevel=0<CR>
    nmap <leader>f1 :set foldlevel=1<CR>
    nmap <leader>f2 :set foldlevel=2<CR>
    nmap <leader>f3 :set foldlevel=3<CR>
    nmap <leader>f4 :set foldlevel=4<CR>
    nmap <leader>f5 :set foldlevel=5<CR>
    nmap <leader>f6 :set foldlevel=6<CR>
    nmap <leader>f7 :set foldlevel=7<CR>
    nmap <leader>f8 :set foldlevel=8<CR>
    nmap <leader>f9 :set foldlevel=9<CR>

    " Toggle search highlighting
    nmap <silent> <leader>/ :set invhlsearch<CR>

 
    " Shortcuts
    " Change Working Directory to that of the current file
    cmap cwd lcd %:p:h
    cmap cd. lcd %:p:h
                                                                                                                      
    " Visual shifting (does not exit Visual mode)
    vnoremap < <gv
    vnoremap > >gv

    " Fix home and end keybindings for screen, particularly on mac
    " - for some reason this fixes the arrow keys too. huh.
    map ^[[F $
    imap ^[[F ^O$
    map ^[[H g0
    imap ^[[H ^Og0                                                                                                    

    " For when you forget to sudo.. Really Write the file.
    cmap w!! w !sudo tee % >/dev/null

    " Some helpers to edit mode
    " http://vimcasts.org/e/14
    cnoremap %% <C-R>=expand('%:h').'/'<cr>
    map <leader>ew :e %%
    map <leader>es :sp %%
    map <leader>ev :vsp %%
    map <leader>et :tabe %%

    " Adjust viewports to the same size
    map <Leader>= <C-w>=

    " Map <Leader>ff to display all lines with keyword under cursor
    " and ask which one to jump to
    nmap <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

    " Easier horizontal scrolling
    map zl zL
    map zh zH

" }

" Plugins { 

 " PIV {
     let g:DisableAutoPHPFolding = 0
     let g:PIVAutoClose = 0
 " }

 " OmniComplete {
        if has("autocmd") && exists("+omnifunc")
            autocmd Filetype *
                \if &omnifunc == "" |
                \setlocal omnifunc=syntaxcomplete#Complete |
                \endif
        endif

        "hi Pmenu  guifg=#000000 guibg=#F8F8F8 ctermfg=black ctermbg=Lightgray
        "hi PmenuSbar  guifg=#8A95A7 guibg=#F8F8F8 gui=NONE ctermfg=darkcyan ctermbg=lightgray cterm=NONE
        "hi PmenuThumb  guifg=#F8F8F8 guibg=#8A95A7 gui=NONE ctermfg=lightgray ctermbg=darkcyan cterm=NONE

        " Some convenient mappings
        inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
        inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
        inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
        inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
        inoremap <expr> <C-d>      pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
        inoremap <expr> <C-u>      pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"

        " Automatically open and close the popup menu / preview window
        au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
        set completeopt=menu,preview,longest
    " }

    " SnipMate {
        " Setting the author var
        " If forking, please overwrite in your .vimrc.local file
        let g:snips_author = 'Steve Francia <steve.francia@gmail.com>'
    " }


    " NerdTree {
        map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
        map <leader>e :NERDTreeFind<CR>
        nmap <leader>nt :NERDTreeFind<CR>

        let NERDTreeShowBookmarks=1
        let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
        let NERDTreeChDirMode=0
        let NERDTreeQuitOnOpen=1
        let NERDTreeMouseMode=2
        let NERDTreeShowHidden=1
        let NERDTreeKeepTreeInNewTab=1
        let g:nerdtree_tabs_open_on_gui_startup=0
    " }

    " Tabularize {
        nmap <Leader>a& :Tabularize /&<CR>
        vmap <Leader>a& :Tabularize /&<CR>
        nmap <Leader>a= :Tabularize /=<CR>
        vmap <Leader>a= :Tabularize /=<CR>
        nmap <Leader>a: :Tabularize /:<CR>
        vmap <Leader>a: :Tabularize /:<CR>
        nmap <Leader>a:: :Tabularize /:\zs<CR>
        vmap <Leader>a:: :Tabularize /:\zs<CR>
        nmap <Leader>a, :Tabularize /,<CR>
        vmap <Leader>a, :Tabularize /,<CR>
        nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
        vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
    " }

    " Buffer explorer {
        nmap <leader>b :BufExplorer<CR>
    " }
    

  " ctrlp {
        let g:ctrlp_working_path_mode = 2
        nnoremap <silent> <D-t> :CtrlP<CR>
        nnoremap <silent> <D-r> :CtrlPMRU<CR>
        let g:ctrlp_custom_ignore = {
            \ 'dir':  '\.git$\|\.hg$\|\.svn$',
            \ 'file': '\.exe$\|\.so$\|\.dll$' }

        let g:ctrlp_user_command = {
            \ 'types': {
                \ 1: ['.git', 'cd %s && git ls-files'],
                \ 2: ['.hg', 'hg --cwd %s locate -I .'],
            \ },
            \ 'fallback': 'find %s -type f'
        \ }
    "}

 " Fugitive {
	  nnoremap <silent> <leader>gs :Git<CR>
	  nnoremap <silent> <leader>gd :Gdiffsplit<CR>
	  nnoremap <silent> <leader>gv :Gvdiffsplit<CR>
	  nnoremap <silent> <leader>gc :Git commit<CR>
	  nnoremap <silent> <leader>gb :Git blame<CR>
	  nnoremap <silent> <leader>gl :Git log<CR>
	  nnoremap <silent> <leader>gcl :Gclog<CR>
        nnoremap <silent> <leader>gp :Git push<CR>
    "}
    

 " UndoTree {
        nnoremap <Leader>u :UndotreeToggle<CR>
        " If undotree is opened, it is likely one wants to interact with it.
        let g:undotree_SetFocusWhenToggle=1
    " }


 " PythonMode {
    " Disable if python support not present
        if !has('python') 
            let g:pymode = 1
        endif
        let g:pymode_lint_ignore = "E126,E128,E201,E202,E203,E221,E222,E211,E225,E226,E231,E261,E262,E271,E302,E303,E401,E501,E701,E711,E712,C,W"
    " }

 " vim-go {
    " This option, 'go_fmt_autosave', prevents vim-go from causing error by using ']]'
    "
    " But, in order to use this option, VIM needs to be updated > 7.4, 
    " otherwise 'E117: Unknown function: json_decode' error happens
    " (References: https://github.com/fatih/vim-go/issues/1536, 255, 262)
    "
    "
       " let g:go_fmt_autosave = 0  
    " }

" }

" Functions {

    " UnBundle {
    function! UnBundle(arg, ...)
      let bundle = vundle#config#init_bundle(a:arg, a:000)
      call filter(g:bundles, 'v:val["name_spec"] != "' . a:arg . '"')
    endfunction

    com! -nargs=+         UnBundle
    \ call UnBundle(<args>)
    " }

    " Initialize NERDTree as needed {
    function! NERDTreeInitAsNeeded()
        redir => bufoutput
        buffers!
        redir END
        let idx = stridx(bufoutput, "NERD_tree")
        if idx > -1
            NERDTreeMirror
            NERDTreeFind
            wincmd l
        endif
    endfunction
    " }

    " Strip whitespace {
    function! StripTrailingWhitespace()
        " To disable the stripping of whitespace, add the following to your
        " .vimrc.local file:
        "   let g:spf13_keep_trailing_whitespace = 1
        if !exists('g:spf13_keep_trailing_whitespace')
            " Preparation: save last search, and cursor position.
            let _s=@/
            let l = line(".")
            let c = col(".")
            " do the business:
            %s/\s\+$//e
            " clean up: restore previous search history, and cursor position
            let @/=_s
            call cursor(l, c)
        endif
    endfunction
    " }

" }


" Auto Background change {
  function! AutoSetSolarized()"
  " Auto change by time
  " https://www.vim.org/scripts/script.php?script_id=5210
    let current_time = strftime("%H:%M")
      "echo current_time
    if current_time > "17:00"
      set background=dark
    elseif current_time < "07:00"
      set background=dark
    else
      set background=light
    endif
	if filereadable(expand("~/.vim/pack/themes/opt/solarized8/colors/solarized8_high.vim"))
	  colorscheme solarized8_high
	else 
      colorscheme solarized
	endif
  endfunction"


  let g:solarized_termtrans=0

  if exists("g:loaded_autoSolarized_autoloader")
    finish
  endif
  let g:loaded_autoSolarized_autoload = 1


  noremap <Leader>sc :call AutoSetSolarized()<CR>
  "autocmd VimEnter * call AutoSetSolarized()
"}

" Solarized8 {
" https://github.com/lifepillar/vim-solarized8
  if filereadable(expand("~/.vim/pack/themes/opt/solarized8/colors/solarized8.vim"))
    colorscheme solarized8
    set background=dark
    "colorscheme solarized8_high
  endif
"}


nnoremap <leader>h <C-T>
nnoremap <leader>l <C-]>





" ==========================================
" 프로젝트별 태그 및 Cscope 자동 로드 모듈
" ==========================================
let s:gotagscope_file = expand("~/.gotagscope.vim")
if filereadable(s:gotagscope_file)
    execute 'source ' . s:gotagscope_file
endif



" ==========================================
" [모듈 로드 및 스마트 단축키] gopls 환경 설정
" ==========================================

" 1. [공통] 일반 파일용 cscope/gotags 기본 매핑 (항상 안전하게 동작)
nnoremap <leader>l <C-]>
nnoremap <leader>h <C-T>

" 2. gopls 모듈 파일 확인 및 조건부 로드
let s:gopls_file = expand("~/.gopls.vim")
if filereadable(s:gopls_file)
    " [A] 모듈 로드 성공 시 설정 파일 실행
    execute 'source ' . s:gopls_file
    
    " [B] 모듈이 성공적으로 로드되었을 때만 Go 전용 지능형 단축키 활성화
    augroup vim_go_smart_mappings
        autocmd!
        
        " (1) Go 파일(.go)에서는 cscope 대신 gopls 엔진으로 덮어쓰기
        autocmd FileType go nnoremap <buffer> <leader>l :GoDef<CR>
        autocmd FileType go nnoremap <buffer> <leader>h <C-T>
        
        " (2) 코드 탐색 및 리팩토링 단축키
        autocmd FileType go nnoremap <buffer> <leader>r :GoReferrers<CR>
        autocmd FileType go nnoremap <buffer> <leader>n :GoRename<Space>
        autocmd FileType go nnoremap <buffer> <leader>d :GoDoc<CR>
        autocmd FileType go nnoremap <buffer> <leader>c :GoCallers<CR>
        
        " (3) 자동화 도구 단축키 (if err 자동생성, 인터페이스 구현)
        autocmd FileType go nnoremap <buffer> <leader>ie :GoIfErr<CR>
        autocmd FileType go nnoremap <buffer> <leader>i :GoImpl<Space>
        
        " (4) 빌드 및 테스트 단축키
        autocmd FileType go nnoremap <buffer> <leader>b :GoBuild<CR>
        autocmd FileType go nnoremap <buffer> <leader>t :GoTest<CR>
    augroup END
endif


" ==========================================
"  vim-go 기능
" ==========================================
" vim-go 저장 시 staticcheck(linter) 자동 실행 끄기
let g:go_metalinter_autosave = 0
let g:go_diagnostics_enabled = 0"

" vim-go documentation popup -- currnet mapping key: ,d (NOT shift k)
let g:go_doc_popup_window = 1

" 저장할 때 자동으로 import를 정렬하고 누락된 것을 채워줌
let g:go_fmt_command = "goimports""



" ==========================================
" Mac 환경일 경우에만 시스템 클립보드 연동
" ==========================================
" Currently unnamed or unnamedplus has some issues on Mac, conflict with clipboard
" in this case, use unnamed or "+p (register,+, paste)
if has("mac") || has("macunix")
    "set clipboard=unnamedplus
    set clipboard=unnamed
endif


" ==========================================
" diffoption - set diffopt+= ..."
set diffopt+=iwhiteall,iblank
" ==========================================

" ==========================================
"  universal tag - showing function name
" ==========================================
let g:airline_powerline_fonts = 0  " 0으로 하면 깨지는 화살표 대신 깔끔한 기본 기호 사용
" 현재 함수 이름 표시 (tagbar 연동)
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#whitespace#enabled = 0



" Mac 기본 ctags 대신 Homebrew universal-ctags를 강제로 사용하도록 지정
let g:tagbar_ctags_bin = '/opt/homebrew/bin/ctags'
set updatetime=250 "250ms



" ==========================================
" Airline 이상한 땜빵 기호 깔끔한 영문으로 교체
" ==========================================
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.branch = ' Git:' " 왼쪽 브랜치 이름 깔끔하게

" ==========================================
" [핵심] 오른쪽 하단(Z섹션) 고정 너비 지정으로 흔들림 방지
" %3p: 퍼센트 3자리 고정 (예: 100,  98)
" %4l: 현재 줄 4자리 고정 (예:  569)
" %4L: 전체 줄 4자리 고정 (예: 2991)
" %3c: 현재 열 3자리 고정 (예:   1,  17)
" ==========================================
let g:airline_section_z = '%3p%% LN:%4l/%4L MAX | COL:%3c'
let g:airline_section_y = ''



" =========================================================
" [최종 통합] COC 지능형 점프 + 전통적 Tag Stack(C-T) 유지
" =========================================================

" 1. 하이브리드 점프 함수 (지능형 점프 전 스택에 현재 위치 저장)
function! CocJumpWithTagStack()
    " coc.nvim 함수가 존재할 때만 실행
    if exists('*CocActionAsync')
        let l:tag = expand('<cword>')
        let l:pos = [bufnr('%'), line('.'), col('.'), 0]
        let l:item = {'tagname': l:tag, 'from': l:pos}
        call settagstack(win_getid(), {'items': [l:item]}, 'a')
        
        call CocActionAsync('jumpDefinition')
    else
        " coc가 없는 환경에서는 기존 태그 점프(C-]) 실행
        execute "normal! \<C-]>"
    endif
endfunction

" 2. 팝업 표시 헬퍼 함수 (if 블록 밖으로 꺼내어 범용성 확보)
function! ShowDocumentation()
    if exists('*CocActionAsync') && CocAction('hasProvider', 'hover')
        call CocActionAsync('doHover')
    else
        if &filetype == 'go'
            execute 'GoDoc'
        else
            " coc가 없으면 기본 K (man page) 동작
            call feedkeys('K', 'in')
        endif
    endif
endfunction

" 3. 통합 스마트 매핑 그룹 (어떤 환경에서도 에러 없이 작동)
augroup coc_smart_mappings
    autocmd!
    " Go, C, C++ 파일 공통
    autocmd FileType go,c,cpp nnoremap <buffer> <leader>l :call CocJumpWithTagStack()<CR>
    autocmd FileType go,c,cpp nnoremap <buffer> <leader>h <C-T>
    
    " 설명 팝업
    autocmd FileType go,c,cpp nnoremap <buffer> <leader>d :call ShowDocumentation()<CR>
    autocmd FileType go,c,cpp nnoremap <buffer> K :call ShowDocumentation()<CR>
augroup END



" 4. 자동완성 메뉴 조작 (고급 기능 및 coc가 있을 때만 작동하도록 내부에 방어 로직 결합)

" 헬퍼 함수: 커서 앞에 글자가 있는지 확인 (로컬 스크립트 전용 s: 붙임)
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" <TAB>: 팝업이 켜져있으면 다음 항목, 글자 중간이면 팝업 강제 호출, 아니면 일반 탭
inoremap <silent><expr> <TAB>
    \ exists('g:did_coc_loaded') && coc#pum#visible() ? coc#pum#next(1) :
    \ exists('g:did_coc_loaded') && !<SID>check_back_space() ? coc#refresh() :
    \ "\<Tab>"

" <S-TAB> (Shift+Tab): 팝업이 켜져있으면 이전 항목, 아니면 백스페이스
inoremap <silent><expr> <S-TAB>
    \ exists('g:did_coc_loaded') && coc#pum#visible() ? coc#pum#prev(1) :
    \ "\<C-h>"

" <CR> (Enter): 팝업이 켜져있으면 선택 확정, 아니면 일반 엔터(+서식 정렬)
inoremap <silent><expr> <CR>
    \ exists('g:did_coc_loaded') && coc#pum#visible() ? coc#pum#confirm() :
    \ "\<C-g>u\<CR>\<c-r>=(exists('g:did_coc_loaded') ? coc#on_enter() : '')\<CR>"



" =========================================================
" [OS 통합 설정] Mac(Homebrew) vs Linux(Ubuntu/Docker)
" =========================================================

if has("mac") || has("macunix")
    " 1. Mac: Homebrew 전용 ctags 경로 지정 
    let g:tagbar_ctags_bin = '/opt/homebrew/bin/ctags'
    
    " 2. Mac 클립보드: unnamed (충돌 방지용) 
    set clipboard=unnamed

elseif has("unix")
    " 3. Linux (Ubuntu/Docker): 시스템 기본 경로의 ctags 사용
    " 보통 /usr/bin/ctags 에 위치하므로 따로 지정하지 않아도 알아서 찾습니다.
    if filereadable('/usr/bin/ctags')
        let g:tagbar_ctags_bin = '/usr/bin/ctags'
    endif

    " 4. Linux 클립보드: X11이 없는 서버/Docker 환경 고려
    " 시스템에 xclip이나 xsel이 설치되어 있을 때만 unnamedplus 사용
    if executable('xclip') || executable('xsel')
        set clipboard=unnamedplus
    endif
endif

" 공통: ctags 업데이트 주기 설정
set updatetime=250



" =========================================================
" [통합 UI] 자동완성 팝업(Pmenu) 색상 커스텀 (완벽 방어 및 색상 교정)
" =========================================================

function! ApplyCustomPmenuColors()
    " 1. Vim 기본 팝업창 색상
    " ctermbg=24 는 256색 환경에서 확실히 구분되는 '어두운 파란색(Navy)' 입니다.
	" popup-menu창색을 바꾸려면 Pmenu ctermbg,, CocPum ctermbg, CocFloating ctermbg 적용
    highlight Pmenu ctermbg=239 ctermfg=250 guibg=#1c2c35 guifg=#93a1a1
    highlight PmenuSel ctermbg=32 ctermfg=255 guibg=#268bd2 guifg=#fdf6e3
    highlight PmenuSbar ctermbg=235 guibg=#073642
    highlight PmenuThumb ctermbg=240 guibg=#586e75

    " 2. coc.nvim 전용 플로팅 팝업창 색상 강제 지정
    " (coc가 없는 깡통 컨테이너에서도 에러 없이 안전하게 무시됨)
    highlight CocPum ctermbg=239 ctermfg=250 guibg=#1c2c35 guifg=#93a1a1
    highlight CocMenuSel ctermbg=32 ctermfg=255 guibg=#268bd2 guifg=#fdf6e3
    highlight CocFloating ctermbg=239 ctermfg=250 guibg=#1c2c35 guifg=#93a1a1

    " 팝업창 내부의 '경고(Warning)' 텍스트 색상을 밝은 노란색으로 변경
    highlight CocWarningFloat ctermfg=226 guifg=#ffff00
endfunction

" 3. 열악한 컨테이너/Pod 환경(16색 터미널 등)을 위한 완벽 방어막
if &t_Co >= 256 || has("gui_running")
    augroup CustomPmenuColors
        autocmd!
        " 테마 변경 시점 & Vim 로딩이 완전히 끝난 직후 강제 덮어쓰기
        autocmd ColorScheme * call ApplyCustomPmenuColors()
        autocmd VimEnter * call ApplyCustomPmenuColors()
    augroup END
endif


" =====================================================================
" [버그 픽스 & 하이브리드 팁] Python 플러그인의 ]c, [c 글로벌 매핑 부분 삭제
" 
" 파이썬 플러그인이 Git Diff 기본 이동키를 강제로 덮어쓰는 문제를 해결하되,
" 'nunmap' (노멀 모드 매핑 취소)만 사용하여 두 가지 기능을 모두 살린 세팅
"
" [사용 방법]
" 1. 노멀 모드 (평상시) : ]c 또는 [c 를 누르면 순정 Git Diff(다음/이전 변경점)로 점프
" 2. 비주얼 모드 (파이썬) : 파이썬 파일에서 'v'로 비주얼 모드 진입 후 ]c 를 누르면
"                         플러그인 기능이 발동하여 '클래스(Class) 전체'가 블록 선택
" =====================================================================
augroup FixPythonDiffGlobal
    autocmd!
    " 1. Vim이 모든 플러그인을 다 불러온 직후(VimEnter)에 전역 매핑을 날려버림
    autocmd VimEnter * silent! nunmap ]c
    autocmd VimEnter * silent! nunmap [c
    
    " 2. 혹시라도 파이썬 파일을 열 때 다시 생기는 것을 방지
    autocmd FileType python silent! nunmap <buffer> ]c
    autocmd FileType python silent! nunmap <buffer> [c
augroup END


