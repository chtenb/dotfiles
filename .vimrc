"
" *** WINDOWS FIXES ***
"
set nocompatible
set encoding=utf-8

if has('python3')
  silent! python3 1
endif

if has("win32") && has("gui_running")
python3 << EOF
import os
import re
path = os.environ['PATH'].split(';')

def contains_msvcr_lib(folder):
    try:
        if 'system32' not in folder:
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
" FileType detect
"

autocmd! BufNewFile,BufRead *.vs,*.fs,*gs set ft=glsl
autocmd! BufNewFile,BufRead *.props,*.targets set ft=xml

autocmd BufRead,BufNewFile *.ma set filetype=ma
autocmd BufRead,BufNewFile *.go set filetype=go

autocmd BufRead,BufNewFile *.sage set filetype=python
autocmd BufRead,BufNewFile *.sage set makeprg=sage\ --preparse\ %
autocmd BufRead,BufNewFile *.ipy set filetype=python

autocmd BufRead,BufNewFile *.t4 set filetype=t4
autocmd BufRead,BufNewFile *.tex set filetype=tex


"filetype plugin indent on
"syntax enable

"let g:vimtex_view_general_viewer = 'SumatraPDF.exe'
"let g:vimtex_quickfix_mode = 2

"" Load Vimtex
"let &rtp  = '~/.vim/bundle/vimtex,' . &rtp
"let &rtp .= ',~/.vim/bundle/vimtex/after'

let $PATH .= ';C:\Program Files\MiKTeX 2.9\miktex\bin\x64'
let $PATH .= ';C:\Strawberry\perl\bin'


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

"Plugin 'scrooloose/syntastic'
if has("gui_running")
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'airblade/vim-gitgutter'
"Plugin 'nathanaelkane/vim-indent-guides'
"Plugin 'SirVer/ultisnips'
"Plugin 'bling/vim-airline'
endif
Plugin 'dylanaraps/fff.vim'
"Plugin 'OmniSharp/omnisharp-vim'
" Class browser
"Plugin 'majutsushi/tagbar'
"Plugin 'scrooloose/nerdtree'
Plugin 'chtenb/vim-autoformat'
"Plugin 'honza/vim-snippets'
"Plugin 'easymotion/vim-easymotion'
Plugin 'corntrace/bufexplorer'
Plugin 'xolox/vim-misc'
Plugin 'tpope/vim-sensible'
Plugin 'inkarkat/vim-visualrepeat'
"Plugin 'terryma/vim-multiple-cursors'
Plugin 'markwu/largefile'
Plugin 'mg979/vim-visual-multi'
Plugin 'wellle/targets.vim'
"Plugin 'unblevable/quick-scope'
" Fuzzy File Finder
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'drmikehenry/vim-fontsize'
" Automatic tag file generator
"Plugin 'xolox/vim-easytags'
" Automatic detect tab indent settings
"Plugin 'tpope/vim-sleuth'
Plugin 'chtenb/vim-visgo'
Plugin 'tikhomirov/vim-glsl'
Plugin 'tpope/vim-unimpaired'
" Matchit
Plugin 'vim-scripts/matchit.zip'
" Surround
Plugin 'tpope/vim-surround'
" Extend repeat command functionality
Plugin 'tpope/vim-repeat'
" Gitwrapper
Plugin 'tpope/vim-fugitive'
" NERDCommenter
Plugin 'scrooloose/nerdcommenter'
" Tabularizing
"Plugin 'godlygeek/tabular'
" Better f/t
"Plugin 'dahu/vim-fanfingtastic'
" Be able to increment dates
"Plugin 'tpope/vim-speeddating'
" Ascii drawings
"Plugin 'vim-scripts/DrawIt'
" Automatic reload vim stuff
"Plugin 'xolox/vim-reload'
" Colors
"Plugin 'altercation/vim-colors-solarized'
Plugin 'chriskempson/vim-tomorrow-theme'
"Plugin 'chriskempson/base16-vim'
"Plugin 'tomasr/molokai'
"Plugin 'kien/rainbow_parentheses.vim'
Plugin 'ajh17/Spacegray.vim'
" Language support
Plugin 'tshirtman/vim-cython'
Plugin 'leafgarland/typescript-vim'
Plugin 'mzlogin/vim-markdown-toc'
Plugin 'plasticboy/vim-markdown' " The tabular plugin must come before vim-markdown.
" WARNING: org mode makes vim slow, regardless of filetype opened
"Plugin 'jceb/vim-orgmode'
"Plugin 'derekwyatt/vim-fswitch'
Plugin 'wilsaj/chuck.vim'
Plugin 'othree/html5.vim'
"Plugin 'chrisbra/csv.vim'
"Plugin 'tmhedberg/SimpylFold'
"Plugin 'Konfekt/FastFold'
"Plugin 'kchmck/vim-coffee-script'
Plugin 'einars/js-beautify'
"Plugin 'sillyotter/t4-vim'
"Plugin 'adamclerk/vim-razor'
"Plugin 'lervag/vimtex'
Plugin 'chtenb/vim-tsv'
Plugin 'vim-scripts/w3af.vim'

call vundle#end()             " required
filetype plugin indent on     " required


"
" *** OTHER CONFIGURATION ***
"

" Put plugins and dictionaries in this dir (also on Windows)
let vimDir = '$HOME/.vim'
let &runtimepath.=','.vimDir

" Using double trailing slashes in the path tells vim to enable a feature
" where it avoids name collisions.
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//

set nobackup

" Keep undo history across sessions by storing it in a file
"if has('persistent_undo')
    "let myUndoDir = expand(vimDir . '/undodir')
    "" Create dirs
    "call system('mkdir ' . vimDir)
    "call system('mkdir ' . myUndoDir)
    "let &undodir = myUndoDir
    "set undofile
"endif

" Dashes are very common in identifiers
set iskeyword+=-

" We always want autoindent. Nothing fancy.
set nocindent
set nosmartindent

set number          " Absolute line numbering on current line
set ignorecase      " Do case insensitive matching
set smartcase       " Do smart case matching
set hlsearch        " Incremental search
set autowrite       " Automatically save before commands like :next and :make
set hidden          " Hide buffers when they are abandoned
"set mouse=a         " Enable mouse usage (all modes)
set lazyredraw      " Don't update the display while executing macros
set gdefault        " auto g flag for substitution
set autochdir       " Autochange working directory when opening new file
set list            " Show list characters
set wildignore+=*/tmp/*,*.so,*.swp,*.zip " Makes CtrlP faster
set sidescroll=10

" This makes all Visual mode selections automatically go to the X11 primary selection
set clipboard+=autoselect
set guioptions+=a

" Sanitize indentation settings
set softtabstop=4
set tabstop=4
set shiftwidth=4
set expandtab

" Folding
nnoremap <space> za
let g:SimpylFold_fold_import=0
let g:SimpylFold_fold_docstring=0

let g:vim_markdown_math=1

" Easy motion
" Require tpope/vim-repeat to enable dot repeat support
" Jump to anywhere with only `ss{char}{target}`
" `ss<CR>` repeat last find motion.
nmap s <Plug>(easymotion-s)
"nmap ss <Plug>(easymotion-s)
"nmap S <Plug>(easymotion-s2)
"nmap sl <Plug>(easymotion-lineforward)
"nmap sj <Plug>(easymotion-j)
"nmap sk <Plug>(easymotion-k)
"nmap sh <Plug>(easymotion-linebackward)

let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_startofline = 0 " keep cursor column when JK motion
let g:EasyMotion_use_upper = 1 " Use uppercase target labels and type as a lower case
let g:EasyMotion_smartcase = 1 " type `l` and match `l`&`L`
let g:EasyMotion_use_smartsign_us = 1 " Smartsign (type `3` and match `3`&`#`)

let g:indent_guides_enable_on_vim_startup = 1
let g:airline#extensions#tabline#enabled = 1
nnoremap <C-h> :bprev<CR>
nnoremap <C-l> :bnext<CR>

nnoremap <silent> <esc> :noh<cr><esc>
"nnoremap <silent> <C-c> :syn sync fromstart \| :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-k>

let g:multi_cursor_exit_from_visual_mode=0
let g:multi_cursor_exit_from_insert_mode=0


" Decent quit shortcut
nmap <C-q> :q<CR>
vmap <C-q> :q<CR>
" Decent save shortcut
nmap <C-s> :w<CR>
vmap <C-s> :w<CR>
imap <C-s> <esc>:w<CR>i
" Disable ex mode, it's useless and annoying
nnoremap Q <nop>
" Give Y a sane meaning
nnoremap Y y$
" Give U a sane meaning
nnoremap U <C-r>

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gVzv:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gVzv:call setreg('"', old_reg, old_regtype)<CR>


" TODO:  /command "edit.goto FILE_LINE"
if has("win32")
"Easily send file to visual studio
    "nnoremap <F1> :execute "!start \"C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\Common7\\IDE\\devenv.exe\" /edit " . bufname("%") . " /command \"edit.goto " . (line(".") + 1) . "\""<CR><CR>
    nnoremap <F1> <Esc>
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
"Autoformat code
noremap <F3> :Autoformat<CR>
"Compile
command! Compile let winview=winsaveview()|make|call winrestview(winview)
nnoremap <F5> :w<CR>:Compile<CR><CR>
" Show tagbar
nnoremap <F8> :TagbarToggle<CR>
" YCM's goto definition command
nnoremap <F12> :YcmCompleter GoToDefinitionElseDeclaration<CR>
" Easy grepping
command! -nargs=+ GG execute 'silent Ggrep!' <q-args> | cw | redraw!
" Grep word under cursor, like find all references
nnoremap <S-F12> :GG <cword><CR>

" Let's make it easy to edit this file
nmap <silent> <Leader>ev :e $MYVIMRC<cr>

" URL encode/decode selection
vnoremap <leader>en :!python -c 'import sys,urllib;print urllib.quote(sys.stdin.read().strip())'<cr>
vnoremap <leader>de :!python -c 'import sys,urllib;print urllib.unquote(sys.stdin.read().strip())'<cr>

" Toggle source/header
"nnoremap <c-k><c-o> :FSHere<CR>

let g:UltiSnipsExpandTrigger="<c-j>"
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_complete_in_comments = 1
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_filetype_blacklist = {}
let g:ycm_confirm_extra_conf = 0
if has("win32")
    let g:ycm_path_to_python_interpreter = 'C:\Program Files\Python310\python.exe'
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
"set background=light

"let g:spacegray_underline_search = 1
"let g:spacegray_use_italics = 1
"let g:spacegray_low_contrast = 1

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
    "colorscheme base16-ashes
    colorscheme spacegray
    if has("win32")
        set guifont=Cascadia\ Code:h9,CaskaydiaCove\ NF:h9,Cambria\ Math:h9
    else
        set guifont=mono\ 10
    endif
else
    colorscheme default
endif

"au VimEnter * RainbowParenthesesToggle
"au Syntax * RainbowParenthesesLoadRound
"au Syntax * RainbowParenthesesLoadSquare
"au Syntax * RainbowParenthesesLoadBraces


"
" *** FILETYPE SPECIFIC STUFF ***
"

au BufRead,BufNewFile *.gv,*.dot setfiletype dot

autocmd FileType vim,tex let b:autoformat_autoindent=0
let g:tex_flavor = 'latex'
"let g:autoformat_autoindent = 0
"let g:autoformat_retab = 0
"let g:autoformat_remove_trailing_spaces = 0

au FileType haskell nnoremap <buffer> <F3> :Tab /^[^=]*\zs=<CR>
au FileType haskell nnoremap <buffer> <F5> :HdevtoolsType<CR>
au FileType haskell nnoremap <buffer> <silent> <F6> :HdevtoolsClear<CR>
au FileType haskell set shiftwidth=2

set textwidth=0
"au FileType dot set textwidth=95
au FileType tex set textwidth=150
au FileType text set textwidth=95
au FileType tsv set textwidth=0
" The indent file for python is broken
au FileType python set textwidth=150

au FileType coffee setl shiftwidth=2
au FileType yaml setl shiftwidth=2

autocmd FileType tex set makeprg=pdflatex\ %
autocmd FileType tex set indentexpr=
autocmd FileType tex set indentkeys=
autocmd FileType tex nnoremap <F6> :!bash compile.sh<cr><cr>

" Vimtex options go here

let g:vimtex_view_general_viewer = 'SumatraPDF.exe'
let g:vimtex_quickfix_mode = 2

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
let g:formatters_javascript = ['prettier']

let g:formatterpath = ['C:\Users\Chiel.tenBrinke\Desktop']

setlocal foldmethod=indent foldlevelstart=20 foldminlines=3
augroup XML
    autocmd!
    autocmd FileType xml setlocal foldmethod=indent foldlevelstart=3 foldminlines=3
augroup END

map <F4> :mapclear<CR>:source ~/.vimrc<CR>
source ~/dotfiles/helix.vim/src/unmap.vim
source ~/dotfiles/helix.vim/src/helix.vim
source ~/dotfiles/helix.vim/src/replace.vim
source ~/dotfiles/helix.vim/src/find.vim
source ~/dotfiles/helix.vim/apocryphal.vim
