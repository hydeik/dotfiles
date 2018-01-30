" mapping.vim --- setting vim/nvim key mappings

" Easy escape:"{{{
inoremap jj       <ESC>
inoremap j<Space>  j
cnoremap <expr> j getcmdline()[getcmdpos()-2] ==# 'j' ? "\<BS>\<C-c>" : 'j'
"}}}

" Insert mode Keymappings;"{{{
inoremap <C-a>    <Home>
inoremap <C-b>    <Left>
inoremap <C-d>    <Del>
inoremap <C-e>    <End>
inoremap <C-f>    <Right>
"}}}

" Command line mode keymappings:"{{{
" --- Emacs like cursor move
" <C-a>: move to head
cnoremap <C-a>    <Home>
" <C-b>: previous char
cnoremap <C-b>    <Left>
" <C-d>: delete char
cnoremap <C-d>    <Del>
" <C-e>: move to end
cnoremap <C-e>    <End>
" <C-f>: next char
cnoremap <C-f>    <Right>
" <C-n>: next history
cnoremap <C-n>    <Down>
" <C-p>: previous history
cnoremap <C-p>    <Up>
" <C-y>: paste
cnoremap <C-y>    <C-r>*
" <C-g>: exit
cnoremap <C-g>    <C-c>
"}}}

" Better x
nnoremap x "_x

" Disable Ex-mode.
nnoremap Q  q

" Disable ZZ.
nnoremap ZZ  <Nop>

" Move by display line j [<--> gj, k <--> gk]
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

" Move widows by Ctrl+h,j,k,l
" nnoremap <C-h> <C-w>h
" nnoremap <C-j> <C-w>j
" nnoremap <C-k> <C-w>k
" nnoremap <C-l> <C-w>l

" Y: yank text from cursor position to the EOL
nnoremap Y y$

" +: increment
nnoremap + <C-a>
" -: decrement
nnoremap - <C-x>

" [Space]: Other useful commands "{{{
" Smart space mapping.
nmap  <Space>   [Space]
nnoremap  [Space]   <Nop>
"}}}

" Stop highlighting by <ESC><ESC>
nnoremap <silent><ESC><ESC> :<C-u>set nohlsearch<CR>

