"
" *** VUNDLE CONFIGURATION ***
"
set nocompatible               " be iMproved
filetype off                   " required!
set rtp+=~/.vim/bundle/vundle/
call vundle#begin()

" let Vundle manage Vundle
" required!
Plugin 'gmarik/vundle'

" My Plugins here:
"
"
" *******************************************************
" *********************   VIMIDE   **********************
" ********************  collection  *********************
" *******************                ********************
" Syntax checker support
Plugin 'scrooloose/syntastic'
" Advanced on the fly autocompletion
"Plugin 'Chiel92/YouCompleteMe'
Plugin 'Valloric/YouCompleteMe'
" Class browser
Plugin 'majutsushi/tagbar'
" Filetree browser
Plugin 'scrooloose/nerdtree'
" Autoformatting support
Plugin 'Chiel92/vim-autoformat'
" Snippet support
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
" Buffer explorer
 Plugin 'corntrace/bufexplorer'
" Fuzzy File Finder
"Plugin 'kien/ctrlp.vim'
" Automatic tag file generator
"Plugin 'xolox/vim-easytags'
Plugin 'xolox/vim-misc'
Plugin 'tpope/vim-sensible'
"Plugin 'tpope/vim-sleuth'
" *******************                ********************
" ********************  collection  *********************
" *********************   VIMIDE   **********************
" *******************************************************
"
" Integrated debugger
"Plugin 'jabapyth/vim-debug'
" Matchit
Plugin 'edsono/vim-matchit'
" Surround
Plugin 'tpope/vim-surround'
" Extend repeat command functionality
Plugin 'tpope/vim-repeat'
" Gitwrapper
Plugin 'tpope/vim-fugitive'
" Autoformatting for javascript
Plugin 'einars/js-beautify'
" Solarized colorscheme for vim
Plugin 'altercation/vim-colors-solarized'
" NERDCommenter
Plugin 'scrooloose/nerdcommenter'
" Better HTML5 support
Plugin 'othree/html5.vim'
" Coffee script support
Plugin 'kchmck/vim-coffee-script'
Plugin 'tomasr/molokai'
Plugin 'kien/rainbow_parentheses.vim'
" Tabularizing
Plugin 'godlygeek/tabular'
" Colorscheme
Plugin 'chriskempson/vim-tomorrow-theme'
Plugin 'chriskempson/base16-vim'

call vundle#end()             " required
filetype plugin indent on     " required
"
" Brief help
" :PluginList          - list configured bundles
" :PluginInstall(!)    - install(update) bundles
" :PluginSearch(!) foo - search(or refresh cache first) for foo
" :PluginClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Plugin command are not allowed..

"
" *** OTHER CONFIGURATION ***
"

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
set wildignore+=*/tmp/*,*.so,*.swp,*.zip " Makes CtrlP faster
set gdefault        " auto g flag for substitution
syntax on
set softtabstop=4
set tabstop=4
set shiftwidth=4
set expandtab
set list

let mapleader = ","

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

"Disable annoying help
nnoremap <F1> <Esc>
inoremap <F1> <Esc>
vnoremap <F1> <Esc>
"Open bufferexplorer
noremap <F2> :BufExplorer<CR>
"Autoformat code
noremap <F3> :Autoformat<CR><CR>
"Compile
"noremap <F5> :<C-U>silent make<CR>:redraw!<CR>
nnoremap <F5> :w<CR>:make<CR>:redraw!<CR>
" Decent save shortcut
nnoremap <C-s> :w<CR>
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
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_complete_in_comments = 1
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_completion = 1
"let g:ycm_autoclose_preview_window_after_insertion = 1 "Not working ??
let g:ycm_filetype_blacklist = {}

let g:ycm_csharp_server_stdout_logfile_format = "~/omnisharp_stdout_log_{port}"
let g:ycm_csharp_server_stderr_logfile_format = "~/omnisharp_stderr_log_{port}"
let g:ycm_path_to_python_interpreter = '/usr/bin/python'

" Easytags shouldn't show updatetime warning
let g:easytags_updatetime_warn = 0

" Color settings
set background=dark
"colorscheme solarized
"set t_Co=256

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
    " Convenient fontsize
    set guifont=Monospace\ 11
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
autocmd BufRead,BufNewFile *.tex filetype indent off
"autocmd BufEnter echo &ft
"autocmd FileType tex set autoindent

let g:syntastic_mode_map = { 'mode': 'active',
            \ 'active_filetypes': [],
            \ 'passive_filetypes': ['coffee'] }
let g:syntastic_python_python_exec = 'python3'

let g:syntastic_r_lint_styles = 'list(spacing.indentation.notabs, spacing.indentation.evenindent)'

