" mapping.vim --- setting vim/nvim key mappings

" Stop highlighting by <ESC><ESC>
nnoremap <silent><ESC><ESC> :<C-u>set nohlsearch<CR>
"
inoremap jj <ESC>
" Easy escape."{{{
inoremap jj        <ESC>
inoremap j<Space>  j
cnoremap <expr> j getcmdline()[getcmdpos()-2] ==# 'j' ? "\<BS>\<C-c>" : 'j'
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
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

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
