"""""""""""""""""""
" Helix emulation "
"""""""""""""""""""
" TODO: checkout https://vimhelp.org/options.txt.html#%27selection%27
" and https://vimhelp.org/options.txt.html#%27virtualedit%27
set notimeout
" Do not restrict movements to lines
set whichwrap=<,>,h,l,[,]

" nullify all existing visual keys
source ~/dotfiles/unmap.vim

" No range selections in command mode
xnoremap : v:
" Re-enter visual mode after command/insert mode
cnoremap <CR> <CR>
cnoremap <Esc> <Esc>
inoremap <Esc> <Esc>
" F1 to exit vim visual mode
xnoremap <Esc> <nop>
xnoremap <F1> <Esc>
nmap v vv

"nnoremap b :silent! normal! b<CR>
"nnoremap l :silent! normal! l<CR>
"nnoremap e :silent! normal! e<CR>

" Movement
xnoremap h vh
xnoremap <Left> vh
xnoremap l vl
xnoremap <Right> vl
xnoremap j vgj
xnoremap <Down> vgj
xnoremap k vgk
xnoremap <Up> vgk
" All commands using marks must make sure to overwrite a,b,c before usage.
" Note that [` and ]` will break if any other lowercase marks are in use.
" TODO: the following keys do not behave the same as Helix around newlines
" TODO: make sure movement near file start or end does not break out of helix mode
xnoremap e vmaembviwovbviwvlmc`blmbhvl[`o
xnoremap E vmaEmbviWovBviWvlmc`blmbhvl[`o
xnoremap w vmalwhmb`aeviwovmc`blmbhvl[`o
xnoremap W vmalWhmb`aEviWovmc`blmbhvl[`o
xnoremap b vmabmbviwveviwovhmc`bhmblvh]`o
xnoremap B vmaBmbviWovEviWvhmc`bhmblvh]`o
xnoremap t vvt
xnoremap T vvT
xnoremap f vvf
xnoremap F vvF
xnoremap G Gvv
xnoremap <A-.> vv;
xnoremap <Home> v0v
xnoremap <End> v$v
xnoremap <C-b> v<C-b>v
xnoremap <PageDown> v<C-b>v
xnoremap <C-f> v<C-f>v
xnoremap <PageUp> v<C-f>v
xnoremap <C-u> v<C-u>v
xnoremap <C-d> v<C-d>v
xnoremap <C-i> v<C-i>v
xnoremap <C-o> v<C-o>v
nnoremap j gj
nnoremap k gk
nnoremap e maembviwovbviwvlmc`blmbhvl[`o
nnoremap E maEmbviWovBviWvlmc`blmbhvl[`o
nnoremap w malwhmb`aeviwovmc`blmbhvl[`o
nnoremap W malWhmb`aEviWovmc`blmbhvl[`o
nnoremap b mabmbviwveviwovhmc`bhmblvh]`o
nnoremap B maBmbviWovEviWvhmc`bhmblvh]`o
" TODO: make these motions work across lines
nnoremap t vt
nnoremap T vT
nnoremap f vf
nnoremap F vF

" Changes
source ~/dotfiles/replace.vim
xnoremap R "0pv
xnoremap ~ ~gv
xnoremap ` ugv
xnoremap <A-`> Ugv
xnoremap i v`<i
xnoremap a v`>a
xnoremap I v`<I
xnoremap A v`>A
xnoremap o v`>o
xnoremap O v`<O
xnoremap . v.v
xnoremap u vuv
xnoremap U v<C-R>v
" TODO: not sure what this should do
xnoremap <A-u> vuv
" TODO: not sure what this should do
xnoremap <A-U> v<C-R>v
xnoremap y ygv
" TODO: helix has special behavior for linewise paste
xnoremap p pgv
xnoremap P Pgv
xnoremap > >v
xnoremap < <v
xnoremap = =gv
xnoremap d dv
xnoremap <A-d> "_dv
xnoremap c c
xnoremap <A-c> "_c
xnoremap <C-a> v<C-a>v
xnoremap <C-x> v<C-x>v
" TODO: macros
nnoremap R v"0pv
nnoremap ~ v~
nnoremap ` vgu
nnoremap <A-`> vgU
nnoremap y vy
nnoremap d vd
nnoremap c vc
nnoremap <A-d> v"_d

" Shell
" TODO

" Selection manipulation
xnoremap s v:echo "Not supported in VIM"<CR>gsgv
xnoremap S v:echo "Not supported in VIM"<CR>gsgv
xnoremap <A-s> v:echo "Not supported in VIM"<CR>gsgv
xnoremap <A-_> v:echo "Not supported in VIM"<CR>gsgv
xnoremap & v:echo "Not supported in VIM"<CR>gsgv
xnoremap ; v
nnoremap ; <nop>
xnoremap <A-;> o
nnoremap <A-;> <nop>
xnoremap <A-:> v`<v`>
nnoremap <A-:> <nop>
xnoremap , v:echo "Not supported in VIM"<CR>gsgv
xnoremap <A-,> v:echo "Not supported in VIM"<CR>gsgv
xnoremap C v:echo "Not implemented"<CR>gsgv
xnoremap <A-C> v:echo "Not implemented"<CR>gsgv
xnoremap ( v:echo "Not supported in VIM"<CR>gsgv
xnoremap ) v:echo "Not supported in VIM"<CR>gsgv
xnoremap <A-(> v:echo "Not supported in VIM"<CR>gsgv
xnoremap <A-)> v:echo "Not supported in VIM"<CR>gsgv
xnoremap % vgg0vG$
xnoremap x v:echo "Not implemented"<CR>gsgv
xnoremap X V
xnoremap <A-x> v:echo "Not implemented"<CR>gsgv
xnoremap J Jgv
xnoremap <A-J> v:echo "Not supported in VIM"<CR>gsgv
xnoremap K v:echo "Not supported in VIM"<CR>gsgv
xnoremap <A-K> v:echo "Not supported in VIM"<CR>gsgv
xnoremap <C-c> v:echo "Not implemented"<CR>gsgv
" This could perhaps be approached with b% or something
xnoremap <A-o> v:echo "Not implemented"<CR>gsgv
xnoremap <A-i> v:echo "Not supported in VIM"<CR>gsgv 
xnoremap <A-p> v:echo "Not supported in VIM"<CR>gsgv
xnoremap <A-n> v:echo "Not supported in VIM"<CR>gsgv
nnoremap % gg0vG$
nnoremap x :echo "Not implemented"<CR>
nnoremap X V

" Search
xnoremap / v/
xnoremap ? v?
xnoremap n vgngnvgn
xnoremap N vgNgNvgN
" This may not work in all emulators
vnoremap * y/\V<C-R>=escape(@",'/\')<CR><CR>Ngv
nnoremap n gngnvgn
nnoremap N gNgNvgN

" Goto
xnoremap gg vggv
xnoremap ge vGv
xnoremap gf vgfv
xnoremap gl v$v
xnoremap gh v0v
xnoremap gs v^v
xnoremap gt vHv
xnoremap gc vMv
xnoremap gb vLv
xnoremap gd vgDv
xnoremap gy v:echo "Not implemented"<CR>gsgv
xnoremap gr v:echo "Not implemented"<CR>gsgv
xnoremap gi v:echo "Not implemented"<CR>gsgv
xnoremap ga v<C-^>v
xnoremap gm v:echo "Not implemented"<CR>gsgv
xnoremap gn v:next<CR>v
xnoremap gp v:previous<CR>v
xnoremap g. v`^v
xnoremap gj vjv
xnoremap gk vkv
nnoremap ge G
nnoremap gf gf
nnoremap gl $
nnoremap gh 0
nnoremap gs ^
nnoremap gt H
nnoremap gc M
nnoremap gb L
nnoremap gd gD
nnoremap gy :echo "Not implemented"<CR>
nnoremap gr :echo "Not implemented"<CR>
nnoremap gi :echo "Not implemented"<CR>
nnoremap ga <C-^>
nnoremap gm :echo "Not implemented"<CR>
nnoremap gn :next<CR>
nnoremap gp :previous<CR>
nnoremap g. `^
nnoremap gj j
nnoremap gk k

" Match
xnoremap mm v%v
xnoremap ms v:echo "Not implemented"<CR>gsgv
xnoremap mr v:echo "Not implemented"<CR>gsgv
xnoremap md v:echo "Not implemented"<CR>gsgv
xnoremap ma v:echo "Not implemented"<CR>gsgv
xnoremap mi v:echo "Not implemented"<CR>gsgv

" Window
" TODO Vim matches the defaults, but does not stay in visual mode

" Space
" TODO: almost nothing is supported out of the box
" TODO: investigate select pasted text?
xnoremap <Space>p v"*pv
xnoremap <Space>P v"*Pv
xnoremap <Space>y "*ygv
xnoremap <Space>Y "*ygv
xnoremap <Space>R "*pv
nnoremap <Space>p "*p
nnoremap <Space>P "*P
nnoremap <Space>y v"*y
nnoremap <Space>Y v"*y
nnoremap <Space>R v"*pv

" Unimpaired
" TODO

" Select / extend
" TODO: generate for all movement keys
xnoremap vv <nop>
xnoremap v<Esc> <nop>

xnoremap Zl l
xnoremap Zh h
xnoremap Zj gj
xnoremap Zk gk
xnoremap Ze e
xnoremap Zw w
xnoremap Zb b
xnoremap Zgl $
xnoremap Zgh 0
xnoremap Zgs ^

xmap vl Zlv
xmap vl Zlv
xmap vh Zhv
xmap vj Zjv
xmap vk Zkv
xmap ve Zev
xmap vw Zwv
xmap vb Zbv
xmap vgl Zglv
xmap vgh Zghv
xmap vgs Zgsv


" Character jumps
" TODO: generate for each character

" Apocryphal
map L vglv
map H vghv
