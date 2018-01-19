" mapping.vim --- setting vim/nvim key mappings

" Stop highlighting by <ESC><ESC>
nnoremap <silent><ESC><ESC> :<C-u>set nohlsearch<CR>
"
" Map jj to ESC
inoremap jj <ESC>

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
