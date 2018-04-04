" mapping.vim --- setting vim/nvim key mappings

" Easy escape:"{{{
inoremap jj        <ESC>
inoremap j<Space>  j
cnoremap <expr> j  getcmdline()[getcmdpos()-2] ==# 'j' ? "\<BS>\<C-c>" : 'j'
if exists(':tnoremap')
  tnoremap <ESC>      <C-\><C-n>
  tnoremap jj         <C-\><C-n>
  tnoremap j<Space>   j
endif
"}}}

" Visual mode key mappings:"{{{
" indent by > and < instead of >> and <<
nnoremap >   >>
nnoremap <   <<
" Maintain visual mode after shifting > and <
xnoremap >   >gv
xnoremap <   <gv
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

" Change current word in a repeatable manner
nnoremap cn  *``cgn
nnoremap cN  *``cgN

" Change selected word in a repeatable manner
vnoremap <expr> cn  "y/\\V\<C-r>=escape(@\", '/')\<CR>\<CR>" . "``cgn"
vnoremap <expr> cN  "y/\\V\<C-r>=escape(@\", '/')\<CR>\<CR>" . "``cgN"

" Open/close folding:"{{{
nnoremap <expr> l  foldclosed('.') != -1 ? 'zo' : 'l'
xnoremap <expr> l  foldclosed(line('.')) != -1 ? 'zogv0' : 'l'

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
" nnoremap Q  q

" Disable ZZ.
nnoremap ZZ  <Nop>

" Move widows by Ctrl+h,j,k,l
" nnoremap <C-h> <C-w>h
" nnoremap <C-j> <C-w>j
" nnoremap <C-k> <C-w>k
" nnoremap <C-l> <C-w>l

" Y: yank text from cursor position to the EOL
nnoremap Y y$

" Stop highlighting by <ESC><ESC>
nnoremap <silent><ESC><ESC> :<C-u>set nohlsearch<CR>

" Quit help by 'q'
autocmd MyVimrc FileType help nnoremap <buffer> <silent> q  :q<CR>

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

" Toggle Quickfix window
function! s:toggle_qf() abort
  let nwin = winnr('$')
  cclose
  if nwin == winnr('$')
    botright copen
  endif
endfunction
nnoremap <silent> <Plug>(my-toggle-quickfix)  :<C-u>call <SID>toggle_qf()<CR>
nmap Q <Plug>(my-toggle-quickfix)
" Map q/<ESC> to close quickfix window
autocmd MyVimrc FileType qf nnoremap <buffer> <silent>q      :q<CR>
autocmd MyVimrc FileType qf nnoremap <buffer> <silent><ESC>  :q<CR>

" Toggle LocationList window
function! s:toggle_ll() abort
  try
    let nwin = winnr('$')
    lclose
    if nwin == winnr('$')
      botright lopen
    endif
  catch /^Vim\%((\a\+)\)\=:E776/
    echohl WarningMsg
    redraw | echo 'No location list'
    echohl None
  endtry
endfunction
nnoremap <silent> <Plug>(my-toggle-locationlist)  :<C-u>call <SID>toggle_ll()<CR>
nmap L <Plug>(my-toggle-locationlist)

" Toggle window zoom
"  <C-w>z      : maximize current window
"  <C-w>z again: restore the previous windows
function! s:toggle_window_zoom() abort
  if exists('t:zoom_winrestcmd')
    execute t:zoom_winrestcmd
    unlet t:zoom_winrestcmd
  else
    let t:zoom_winrestcmd = winrestcmd()
    resize
    vertical resize
  endif
endfunction
nnoremap <silent> <Plug>(my-zoom-window) :<C-u>call <SID>toggle_window_zoom()<CR>
nmap <C-w>z     <Plug>(my-zoom-window)
nmap <C-w><C-z> <Plug>(my-zoom-window)

" [Space]: Other useful commands "{{{
" Smart space mapping.

" <Leader>B mapping -- buffer
nnoremap <silent> <Leader>bd :<C-u>bdelete<CR>
nnoremap <silent> <Leader>bD :<C-u>bdelete!<CR>
nnoremap <silent> <Leader>bs :<C-u>wall<CR>
nnoremap <silent> <Leader>bn :<C-u>bnext<CR>
nnoremap <silent> <Leader>bp :<C-u>bprevious<CR>

let g:lmap.b.d = ['bdelete',   'Delete current buffer']
let g:lmap.b.D = ['bdelete!',  'Delete current buffer (force)']
let g:lmap.b.s = ['wall',      'Save all buffers (wall)']
let g:lmap.b.n = ['bnext',     'Next buffer']
let g:lmap.b.p = ['bprevious', 'Previous buffer']

" <Leader>Q mapping -- quit
nnoremap <silent> <Leader>qq :qall<CR>
nnoremap <silent> <Leader>qQ :qall!<CR>

" <Leader>W mapping -- window
nnoremap <silent> <Leader>ws :split<CR>
nnoremap <silent> <Leader>wv :vsplit<CR>
nnoremap <silent> <Leader>wd :close<CR>
nnoremap <silent> <Leader>wO :only<CR>
nnoremap <silent> <Leader>wD <c-w>j:close<CR>
nnoremap <silent> <Leader>w= <c-w>=<CR>
nmap     <silent> <Leader>wz <Plug>(my-zoom-window)

nnoremap <Leader>wl <c-w>l
nnoremap <Leader>wh <c-w>h
nnoremap <Leader>wj <c-w>j
nnoremap <Leader>wk <c-w>k
nnoremap <silent> <Leader>wL <c-w>L
nnoremap <silent> <Leader>wH <c-w>H
nnoremap <silent> <Leader>wJ <c-w>J
nnoremap <silent> <Leader>wK <c-w>K
nnoremap <silent> <Leader>wP <c-w>\|<c-w>_
"}}}
