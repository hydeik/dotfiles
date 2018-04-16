" mapping.vim --- setting vim/nvim key mappings

" Easy escape:
inoremap jj        <ESC>
inoremap j<Space>  j
cnoremap <expr> j  getcmdline()[getcmdpos()-2] ==# 'j' ? "\<BS>\<C-c>" : 'j'
if exists(':tnoremap')
  tnoremap <ESC>      <C-\><C-n>
  tnoremap jj         <C-\><C-n>
  tnoremap j<Space>   j
endif

" Visual mode key mappings:
" indent by > and < instead of >> and <<
nnoremap >   >>
nnoremap <   <<
" Maintain visual mode after shifting > and <
xnoremap >   >gv
xnoremap <   <gv

" Insert mode key mappings
" Emacs-like cursor move in insert mode and command line mode:"{{{
inoremap <C-a>    <Home>
inoremap <C-b>    <Left>
inoremap <C-d>    <Del>
inoremap <C-e>    <End>
inoremap <C-f>    <Right>

" Command-line mode key mappings:
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

" Disable Ex-mode
nnoremap Q  <Nop>

" Disable ZZ.
nnoremap ZZ  <Nop>

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
nmap <C-w>z       <Plug>(my-zoom-window)
nmap <C-w><C-z>   <Plug>(my-zoom-window)

" [Space]: Other useful commands "{{{
" Smart space mapping.

" <Leader>t mapping -- (toggle) options
nnoremap <silent> <Leader>ts  :setlocal spell!<CR>
nnoremap <silent> <Leader>tn  :setlocal nonumber!<CR>
nnoremap <silent> <Leader>tl  :setlocal nolist!<CR>
nnoremap <silent> <Leader>tw  :setlocal wrap! breakindent!<CR>

" Window/Tabs operation
" nnoremap [Window] <Nop>
" nmap s   [Window]
" Move windown y TAB
nnoremap <silent> <Tab>    <C-w>w
nnoremap <silent> <S-Tab>  <C-w>W
" Resize window by Shift+arrow
nnoremap <S-Left>   <C-w><
nnoremap <S-Right>  <C-w>>
nnoremap <S-Up>     <C-w>+
nnoremap <S-Down>   <C-w>-

" split window horizontally and move to new windown
nnoremap <silent> <Leader>ws  :<C-u>split<CR>:wincmd w<CR>
" split window vertically and move to new windown
nnoremap <silent> <Leader>wv  :<C-u>vsplit<CR>:wincmd w<CR>
" new tab
nnoremap <silent> <Leader>wt  :<C-u>tabnew<CR>
" close window
nnoremap <silent> <Leader>wd  :<C-u>close<CR>
" only current window
nnoremap <silent> <Leader>wo  :<C-u>only<CR>
" equal size window
nnoremap <silent> <Leader>w=   <c-w>=<CR>
" Zoom windown
nmap     <silent> <Leader>wz   <Plug>(my-zoom-window)
