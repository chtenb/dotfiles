"
" *** VUNDLE CONFIGURATION ***
"
set nocompatible               " be iMproved
filetype off                   " required!
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" My Bundles here:
"
"
" *******************************************************
" *********************   VIMIDE   **********************
" ********************  collection  *********************
" *******************                ********************
" Syntax checker support
Bundle 'scrooloose/syntastic'
" Advanced on the fly autocompletion
"Bundle 'Chiel92/YouCompleteMe'
Bundle 'Valloric/YouCompleteMe'
" Class browser
Bundle "majutsushi/tagbar"
" Filetree browser
Bundle 'scrooloose/nerdtree'
" Autoformatting support
Bundle 'Chiel92/vim-autoformat'
" Snippet support
Bundle 'SirVer/ultisnips'
" Buffer explorer
 Bundle 'corntrace/bufexplorer'
" Fuzzy File Finder
"Bundle 'kien/ctrlp.vim'
" Automatic tag file generator
Bundle 'xolox/vim-easytags'
Bundle 'xolox/vim-misc'
Bundle 'tpope/vim-sensible'
"Bundle 'tpope/vim-sleuth'
" *******************                ********************
" ********************  collection  *********************
" *********************   VIMIDE   **********************
" *******************************************************
"
" Integrated debugger
"Bundle 'jabapyth/vim-debug'
" Matchit
Bundle 'edsono/vim-matchit'
" Surround
Bundle 'tpope/vim-surround'
" Extend repeat command functionality
Bundle 'tpope/vim-repeat'
" Gitwrapper
Bundle 'tpope/vim-fugitive'
" Autoformatting for javascript
Bundle 'einars/js-beautify'
" Solarized colorscheme for vim
Bundle 'altercation/vim-colors-solarized'
" NERDCommenter
Bundle 'scrooloose/nerdcommenter'
" Better HTML5 support
Bundle 'othree/html5.vim'
" Better C# compiler plugin
Bundle 'Chiel92/vim-csharp-compiler-plugin'
" Coffee script support
Bundle 'kchmck/vim-coffee-script'
Bundle 'tomasr/molokai'
Bundle 'kien/rainbow_parentheses.vim'
" Haskell stuff
Bundle 'bitc/vim-hdevtools'
Bundle 'kana/vim-filetype-haskell'
Bundle 'godlygeek/tabular'
"Bundle 'frerich/unicode-haskell'
"Bundle 'lukerandall/haskellmode-vim'

filetype plugin indent on     " required!
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..

"
" *** OTHER CONFIGURATION ***
"

set number          " Absolute line numbering on current line
set relativenumber  " Relative line numbering on other lines
set undofile        " remember undo history
set undodir=$HOME/.vimundo/ " set a directory to store the undo history
set ignorecase      " Do case insensitive matching
set smartcase       " Do smart case matching
set hlsearch        " Incremental search
set autowrite       " Automatically save before commands like :next and :make
set hidden          " Hide buffers when they are abandoned
set mouse=a         " Enable mouse usage (all modes)
set lazyredraw      " Don't update the display while executing macros
set wildignore+=*/tmp/*,*.so,*.swp,*.zip " Makes CtrlP faster
set gdefault        " auto g flag for substitution
syntax on
set softtabstop=4
set tabstop=4
set shiftwidth=4
set expandtab
set list

let mapleader = ","

"set colorscheme to solarized
set background=dark
colorscheme solarized
set t_Co=256

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

"Open bufferexplorer
noremap <F2> :BufExplorer<CR>
"Autoformat code
noremap <F3> :Autoformat<CR><CR>
"Compile
"noremap <F4> :<C-U>silent make<CR>:redraw!<CR>
nnoremap <F4> :w<CR>:make<CR>:redraw!<CR>
" Disable ex mode, it's useless and annoying. Map Q to format instead.
nnoremap Q gq
" Let's make it easy to edit this file
nmap <silent> ,ev :e $MYVIMRC<cr>
" And to source this file as well
nmap <silent> ,sv :so $MYVIMRC<cr>
" Easily use YCM's goto definition command
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
" Give Y a sane meaning
nnoremap Y y$

let g:UltiSnipsExpandTrigger="<c-j>"
let g:ycm_complete_in_comments = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_filetype_blacklist = {}

let g:ycm_csharp_server_stdout_logfile_format = "~/omnisharp_stdout_log_{port}"
let g:ycm_csharp_server_stderr_logfile_format = "~/omnisharp_stderr_log_{port}"
let g:ycm_path_to_python_interpreter = '/usr/bin/python'

" Easytags shouldn't show updatetime warning
let g:easytags_updatetime_warn = 0

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
endif

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" FILETYPE SPECIFIC STUFF

au FileType haskell nnoremap <buffer> <F3> :Tab /^[^=]*\zs=<CR>
au FileType haskell nnoremap <buffer> <F5> :HdevtoolsType<CR>
au FileType haskell nnoremap <buffer> <silent> <F6> :HdevtoolsClear<CR>
au FileType haskell set shiftwidth=2

au FileType cs compiler xbuild

autocmd BufRead,BufNewFile *.sage set filetype=python
autocmd BufRead,BufNewFile *.sage set makeprg=sage\ --preparse\ %

au FileType coffee setl shiftwidth=2
au FileType python set textwidth=140

autocmd FileType tex set makeprg=pdflatex\ %

let g:syntastic_mode_map = { 'mode': 'active',
            \ 'active_filetypes': [],
            \ 'passive_filetypes': ['coffee'] }
