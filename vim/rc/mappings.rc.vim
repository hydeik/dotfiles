" mapping.vim --- setting vim/nvim key mappings

" Easy escape:"{{{
inoremap jj       <ESC>
inoremap j<Space>  j
cnoremap <expr> j getcmdline()[getcmdpos()-2] ==# 'j' ? "\<BS>\<C-c>" : 'j'
"}}}

" Emacs-like cursor move in insert mode and command line mode:"{{{
inoremap <C-a>    <Home>
inoremap <C-b>    <Left>
inoremap <C-d>    <Del>
inoremap <C-e>    <End>
inoremap <C-f>    <Right>

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

" Open/close folding:"{{{
nnoremap <expr>l  foldclosed('.') != -1 ? 'zo' : 'l'
xnoremap <expr>l  foldclosed(line('.')) != -1 ? 'zogv0' : 'l'

nnoremap <silent><C-_> :<C-u>call <SID>smart_foldcloser()<CR>
function! s:smart_foldcloser()
  if foldlevel('.') == 0
    normal! zM
    return
  endif

  let foldc_lnum = foldclosed('.')
  normal! zc
  if foldc_lnum == -1
    return
  endif

  if foldclosed('.') != foldc_lnum
    return
  endif
  normal! zM
endfunction
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
" nmap  <Space>   [Space]
" nnoremap  [Space]   <Nop>
"}}}

" Stop highlighting by <ESC><ESC>
nnoremap <silent><ESC><ESC> :<C-u>set nohlsearch<CR>

" Quit help by 'q'
autocmd MyVimrc FileType help nnoremap <buffer> q  :q<CR>

" leave terminal mode by <ESC>
if has('nvim')
  tnoremap <silent><ESC>    <C-\><C-n>
endif

" Source a vim script
if !exists('*s:source_script')
  function s:source_script(path) abort
    let path = expand(a:path)
    if !filereadable(path)
      return
    endif
    execute 'source' fnameescape(path)
    echomsg printf('"%s" has sourced (%s)',
          \ simplify(fnamemodify(path, ':~:.')), strftime('%c'))
  endfunction
endif

" Map <F10> to reload current vim script
nnoremap <silent><F10>  :<C-u>call <SID>source_script('%')<CR>

