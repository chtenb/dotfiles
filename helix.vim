"""""""""""""""""""
" Helix emulation "
"""""""""""""""""""

set notimeout
" Do not restrict movements to lines
set whichwrap=<,>,h,l,[,]
" Enter helix/visual mode by default
au BufEnter <Esc>:normal! <Esc>v<CR>

" No range selections in command mode
xmap : v:
" Re-enter visual mode after command/insert mode
cmap <CR> <CR>gsv
inoremap <Esc> <Esc>v
" F1 to exit helix/visual mode
xnoremap <Esc> <nop>
xnoremap <F1> <Esc>
nnoremap <F1> v

"nnoremap b :silent! normal! b<CR>
"nnoremap l :silent! normal! l<CR>
"nnoremap e :silent! normal! e<CR>

" Movement
xnoremap h vhv
xnoremap <Left> vhv
xnoremap l vlv
xnoremap <Right> vlv
xnoremap j vgjv
xnoremap <Down> vgjv
xnoremap k vgkv
xnoremap <Up> vgkv
xnoremap e vmaembviwovbviwvlmc`blmbhvl[`o
xnoremap E vmaEmbviWovBviWvlmc`blmbhvl[`o
xnoremap w v:echo "Not implemented"<CR>gsgv
xnoremap W v:echo "Not implemented"<CR>gsgv
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

" Changes
"xnoremap r r TODO generate for all keys
" Perhaps I can leverage omap to make sure nothing is cancelled
" and reduce the amount of generations.
" omap ... ...v
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

" Shell
" TODO

" Selection manipulation
xnoremap s v:echo "Not supported in VIM"<CR>gsgv
xnoremap S v:echo "Not supported in VIM"<CR>gsgv
xnoremap <A-s> v:echo "Not supported in VIM"<CR>gsgv
xnoremap <A-_> v:echo "Not supported in VIM"<CR>gsgv
xnoremap & v:echo "Not supported in VIM"<CR>gsgv
xnoremap ; vv
xnoremap <A-;> o
xnoremap <A-:> v`<v`>
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
xnoremap X Vv
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

" Search
xnoremap / v:echo "Not implemented"<CR>gsgv
xnoremap ? v:echo "Not implemented"<CR>gsgv
xnoremap n v:echo "Not implemented"<CR>gsgv
xnoremap N v:echo "Not implemented"<CR>gsgv
xnoremap * v:echo "Not implemented"<CR>gsgv

" Goto
xnoremap gg vggv
xnoremap ge vGv
xnoremap gf vgfv
xnoremap gl v$hv
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
xnoremap <Space>p v"*pv
xnoremap <Space>P v"*Pv
xnoremap <Space>y "*ygv
xnoremap <Space>Y "*ygv
xnoremap <Space>R "*pv

" Unimpaired
" TODO

" Select / extend
" TODO: generate for all movement keys
xnoremap vv <nop>
xnoremap v<Esc> <nop>
xnoremap v_l l
xnoremap v_h h
xnoremap v_j gj
xnoremap v_k gk
xnoremap v_e e
xnoremap v_w w
xnoremap v_b b
xmap vl v_lv
xmap vh v_hv
xmap vj v_jv
xmap vk v_kv
xmap ve v_ev
xmap vw v_wv
xmap vb v_bv

" Character jumps
" TODO: generate for each character

" Apocryphal
"xmap Z; oZ
"xmap Z<A-;> <Esc>vZ
"xmap Z, ;Z
"xmap Zx v^v$hZ
"xmap ZX VZ
"xmap Z vv^Z
"xmap ZL vv$hZ
