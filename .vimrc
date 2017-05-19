

"
" *** WINDOWS FIXES ***
"


if has("win32") && has("gui_running")
python << EOF
import os
import re
path = os.environ['PATH'].split(';')

def contains_msvcr_lib(folder):
    try:
        for item in os.listdir(folder):
            if re.match(r'msvcr\d+\.dll', item):
                return True
    except:
        pass
    return False

path = [folder for folder in path if not contains_msvcr_lib(folder)]
os.environ['PATH'] = ';'.join(path)
EOF
endif

if has("win32") && !has("gui_running")
    set shell=/usr/bin/bash
endif


"
" *** VUNDLE CONFIGURATION ***
"


set nocompatible               " be iMproved
filetype off                   " required!
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()


" let Vundle manage Vundle
" required!
Plugin 'VundleVim/Vundle.vim'

" *******************************************************
" *********************   VIMIDE   **********************
" ********************  collection  *********************
" *******************                ********************
" Syntax checker support
Plugin 'scrooloose/syntastic'
" Advanced on the fly autocompletion
if has("gui_running")
Plugin 'Valloric/YouCompleteMe'
endif
" Class browser
Plugin 'majutsushi/tagbar'
" Filetree browser
Plugin 'scrooloose/nerdtree'
" Autoformatting support
Plugin 'Chiel92/vim-autoformat'
" Snippet support
if has("gui_running")
Plugin 'SirVer/ultisnips'
endif
Plugin 'honza/vim-snippets'
" Easy motion
Plugin 'easymotion/vim-easymotion'
" Buffer explorer
Plugin 'corntrace/bufexplorer'
Plugin 'xolox/vim-misc'
Plugin 'tpope/vim-sensible'
if has("gui_running")
Plugin 'bling/vim-airline'
endif
Plugin 'terryma/vim-multiple-cursors'
" Fuzzy File Finder
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'drmikehenry/vim-fontsize'
" Automatic tag file generator
"Plugin 'xolox/vim-easytags'
" Automatic detect tab indent settings
"Plugin 'tpope/vim-sleuth'
" *******************                ********************
" ********************  collection  *********************
" *********************   VIMIDE   **********************
" *******************************************************
"
" Integrated debugger. Only support python and php.
"Plugin 'jabapyth/vim-debug'
" Matchit
Plugin 'edsono/vim-matchit'
" Surround
Plugin 'tpope/vim-surround'
" Extend repeat command functionality
Plugin 'tpope/vim-repeat'
" Gitwrapper
Plugin 'tpope/vim-fugitive'
" NERDCommenter
Plugin 'scrooloose/nerdcommenter'
" Tabularizing
Plugin 'godlygeek/tabular'
" Better f/t
Plugin 'dahu/vim-fanfingtastic'
" Be able to increment dates
Plugin 'tpope/vim-speeddating'
" Ascii drawings
Plugin 'vim-scripts/DrawIt'
" Automatic reload vim stuff
Plugin 'xolox/vim-reload'
" Colors
Plugin 'altercation/vim-colors-solarized'
Plugin 'chriskempson/vim-tomorrow-theme'
Plugin 'chriskempson/base16-vim'
Plugin 'tomasr/molokai'
Plugin 'kien/rainbow_parentheses.vim'
" Language support
Plugin 'tshirtman/vim-cython'
Plugin 'leafgarland/typescript-vim'
Plugin 'jceb/vim-orgmode'
Plugin 'derekwyatt/vim-fswitch'
Plugin 'wilsaj/chuck.vim'
Plugin 'othree/html5.vim'
Plugin 'chrisbra/csv.vim'
"Plugin 'kchmck/vim-coffee-script'
Plugin 'einars/js-beautify'
Plugin 'sillyotter/t4-vim'
Plugin 'adamclerk/vim-razor'

call vundle#end()             " required
filetype plugin indent on     " required


"
" *** OTHER CONFIGURATION ***
"


" We always want autoindent. Nothing fancy.
set nocindent
set nosmartindent

set number          " Absolute line numbering on current line
set undofile        " Remember undo history
set undodir=$HOME/.vimundo/ " set a directory to store the undo history
set ignorecase      " Do case insensitive matching
set smartcase       " Do smart case matching
set hlsearch        " Incremental search
set autowrite       " Automatically save before commands like :next and :make
set hidden          " Hide buffers when they are abandoned
set mouse=a         " Enable mouse usage (all modes)
set lazyredraw      " Don't update the display while executing macros
set gdefault        " auto g flag for substitution
set autochdir       " Autochange working directory when opening new file
set list            " Show list characters
set wildignore+=*/tmp/*,*.so,*.swp,*.zip " Makes CtrlP faster

" This makes all Visual mode selections automatically go to the X11 primary selection
set clipboard+=autoselect
set guioptions+=a

" Sanitize indentation settings
set softtabstop=4
set tabstop=4
set shiftwidth=4
set expandtab

let mapleader = ","


" Easy motion
" Require tpope/vim-repeat to enable dot repeat support
" Jump to anywhere with only `ss{char}{target}`
" `ss<CR>` repeat last find motion.
nmap ss <Plug>(easymotion-s)
map S <Plug>(easymotion-s2)

map sl <Plug>(easymotion-lineforward)
map sj <Plug>(easymotion-j)
map sk <Plug>(easymotion-k)
map sh <Plug>(easymotion-linebackward)

" keep cursor column when JK motion
let g:EasyMotion_startofline = 0
" Use uppercase target labels and type as a lower case
let g:EasyMotion_use_upper = 1
" type `l` and match `l`&`L`
let g:EasyMotion_smartcase = 1
" Smartsign (type `3` and match `3`&`#`)
let g:EasyMotion_use_smartsign_us = 1


" Decent quit shortcut
nnoremap <C-q> :q<CR>
" Decent save shortcut
nnoremap <C-s> :w<CR>
" Disable ex mode, it's useless and annoying
nnoremap Q <nop>
" Give Y a sane meaning
nnoremap Y y$
" Give U a sane meaning
nnoremap U <C-r>

" TODO:  /command "edit.goto FILE_LINE"
if has("win32")
"Easily send file to visual studio
    nnoremap <F1> :execute "!start \"C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\Common7\\IDE\\devenv.exe\" /edit " . bufname("%") . " /command \"edit.goto " . (line(".") + 1) . "\""<CR><CR>
else
    nnoremap <F1> <Esc>
endif

"Fuzzy file finder
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\.git$\|\.hg$\|\.svn$\|\.yardoc$',
    \ 'file': '\.exe$\|\.so$\|\.dat$\|\.obj$\|\.bak$\|\.orig$\|\.dll$\|\.lib$\|\.pdf$'
    \ }
nnoremap <c-p> :CtrlPMixed<CR>
"Disable annoying help
inoremap <F1> <Esc>
vnoremap <F1> <Esc>
"Open bufferexplorer
noremap <F2> :BufExplorer<CR>
"Autoformat code
noremap <F3> :Autoformat<CR>
"Compile
nnoremap <F5> :w<CR>:make<CR>:redraw!<CR>
" Show tagbar
nnoremap <F8> :TagbarToggle<CR>
" YCM's goto definition command
nnoremap <F12> :YcmCompleter GoToDefinitionElseDeclaration<CR>
" Easy grepping
command! -nargs=+ GG execute 'silent Ggrep!' <q-args> | cw | redraw!
" Grep word under cursor, like find all references
nnoremap <S-F12> :GG <cword><CR>

" Let's make it easy to edit this file
nmap <silent> ,ev :e $MYVIMRC<cr>

" Toggle source/header
nnoremap <c-k><c-o> :FSHere<CR>


let g:UltiSnipsExpandTrigger="<c-j>"
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_complete_in_comments = 1
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_filetype_blacklist = {}
let g:ycm_confirm_extra_conf = 0
if has("win32")
    let g:ycm_path_to_python_interpreter = 'c:\Program Files (x86)\Python 3.5\python.exe'
else
    let g:ycm_path_to_python_interpreter = '/usr/bin/python'
endif

"let g:autoformat_verbosemode = 1

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

" When vimdiffing, always wrap lines
au VimEnter * if &diff | execute 'windo set wrap' | endif


" Color settings
set background=dark

"Some settings for the GUI
if has("gui_running")
    "disable scrollbars
    set guioptions+=LlRrb
    set guioptions-=LlRrb
    "remove toolbar
    set guioptions-=T
    "remove menu
    set guioptions-=m
    "Disable all cursor blinking:
    set guicursor+=a:blinkon0
    colorscheme base16-ashes
    if has("win32")
        set guifont=consolas:h11
    else
        set guifont=mono\ 11
    endif
endif

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces


"
" *** FILETYPE SPECIFIC STUFF ***
"

autocmd FileType vim,tex let b:autoformat_autoindent=0
"let g:autoformat_autoindent = 0
"let g:autoformat_retab = 0
"let g:autoformat_remove_trailing_spaces = 0

autocmd BufRead,BufNewFile *.ma set filetype=ma
autocmd BufRead,BufNewFile *.go set filetype=go

au FileType haskell nnoremap <buffer> <F3> :Tab /^[^=]*\zs=<CR>
au FileType haskell nnoremap <buffer> <F5> :HdevtoolsType<CR>
au FileType haskell nnoremap <buffer> <silent> <F6> :HdevtoolsClear<CR>
au FileType haskell set shiftwidth=2

au FileType cs compiler xbuild

autocmd BufRead,BufNewFile *.sage set filetype=python
autocmd BufRead,BufNewFile *.sage set makeprg=sage\ --preparse\ %
autocmd BufRead,BufNewFile *.ipy set filetype=python

set textwidth=0
au FileType markdown set textwidth=95
au FileType text set textwidth=95

au FileType coffee setl shiftwidth=2

autocmd BufRead,BufNewFile *.tex set filetype=tex
autocmd FileType tex set makeprg=pdflatex\ %
autocmd FileType tex set indentexpr=
autocmd FileType tex set indentkeys=
autocmd FileType tex nnoremap <F6> :!bash compile.sh<cr><cr>

let g:syntastic_mode_map = { 'mode': 'active',
    \ 'active_filetypes': [],
    \ 'passive_filetypes': ['coffee'] }
"let g:syntastic_python_python_exec = 'python34'

let g:syntastic_r_lint_styles = 'list(spacing.indentation.notabs, spacing.indentation.evenindent)'

let g:NERDCustomDelimiters = {
    \ 'html': {  'left': '<!-- ', 'right': '-->', 'leftAlt': '/*','rightAlt': '*/' },
    \ 'xhtml': {  'left': '<!-- ', 'right': '-->', 'leftAlt': '/*','rightAlt': '*/'},
    \ 'ma': { 'left': '#' },
    \ 'chuck': { 'left': '//', 'leftAlt': '/*', 'rightAlt': '*/' }
    \}
let NERD_html_alt_style=1

let g:syntastic_enable_perl_checker = 1
let g:syntastic_perl_checkers = ['perl']

let g:syntastic_lua_checkers = ['luacheck']
