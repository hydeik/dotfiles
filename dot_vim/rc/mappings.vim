"-----------------------------------------------------------------------------
" ~/.config/nvim/rc/mapping.vim --- setting vim/nvim key mappings

"---------------------------------------------------------------------------"
" Commands \ Modes | Normal | Insert | Command | Visual | Select | Operator |
"------------------|--------|--------|---------|--------|--------|----------|
" map  / noremap   |    @   |   -    |    -    |   @    |   @    |    @     |
" nmap / nnoremap  |    @   |   -    |    -    |   -    |   -    |    -     |
" vmap / vnoremap  |    -   |   -    |    -    |   @    |   @    |    -     |
" omap / onoremap  |    -   |   -    |    -    |   -    |   -    |    @     |
" xmap / xnoremap  |    -   |   -    |    -    |   @    |   -    |    -     |
" smap / snoremap  |    -   |   -    |    -    |   -    |   @    |    -     |
" map! / noremap!  |    -   |   @    |    @    |   -    |   -    |    -     |
" imap / inoremap  |    -   |   @    |    -    |   -    |   -    |    -     |
" cmap / cnoremap  |    -   |   -    |    @    |   -    |   -    |    -     |
"---------------------------------------------------------------------------"

" Basic mappings {{{
" -----
" Disable Ex-mode, remap to register macros
nnoremap Q  q

" Disable dangerous/annoying default mappings
"   ZZ - Save current file and quit
"   ZQ - Quit without checking changes (:q!)
nnoremap ZZ  <Nop>
nnoremap ZQ  <Nop>

" Useless command. M - to middle line of window
nnoremap M  m

" Y: yank text from cursor position to the EOL
nnoremap Y y$

" Better x
" nnoremap x "_x

" Emacs-like cursor move in insert/command mode
inoremap <C-a>  <Home>
inoremap <C-b>  <Left>
inoremap <C-d>  <Del>
inoremap <C-e>  <End>
inoremap <C-f>  <Right>

cnoremap <C-a>  <Home>
cnoremap <C-b>  <Left>
cnoremap <C-d>  <Del>
cnoremap <C-e>  <End>
cnoremap <C-f>  <Right>
cnoremap <C-n>  <Down>
cnoremap <C-p>  <Up>

" Smart scroll with <C-f>, <C-b>.
noremap <expr> <C-f> max([winheight(0) - 2, 1])
      \ . "\<C-d>" . (line('w$') >= line('$') ? "L" : "M")
noremap <expr> <C-b> max([winheight(0) - 2, 1])
      \ . "\<C-u>" . (line('w0') <= 1 ? "H" : "M")

" Enable undo <C-w> and <C-u> in insert mode.
inoremap <C-w>  <C-g>u<C-w>
inoremap <C-u>  <C-g>u<C-u>

" <C-y>: paste
cnoremap <C-y>    <C-r>*
" <C-g>: exit
cnoremap <C-g>    <C-c>

" Indent by > and < instead of >> and <<
nnoremap >   >>
nnoremap <   <<
" Maintain visual mode after shifting > and <
xnoremap >   >gv
xnoremap <   <gv

" Easy escape
inoremap jj        <ESC>
inoremap j<Space>  j
cnoremap <expr> j  getcmdline()[getcmdpos()-2] ==# 'j' ? "\<BS>\<C-c>" : 'j'

" Start new line from any cursor position
inoremap <S-Return> <C-o>o

" Change current word in a repeatable manner
nnoremap cn  *``cgn
nnoremap cN  *``cgN

" Change selected word in a repeatable manner
vnoremap <expr> cn  "y/\\V\<C-r>=escape(@\", '/')\<CR>\<CR>" . "``cgn"
vnoremap <expr> cN  "y/\\V\<C-r>=escape(@\", '/')\<CR>\<CR>" . "``cgN"

" Close windows with q
nnoremap <silent><expr>q  winnr('$') != 1 ? ':<C-u>close<CR>' : ':<C-u>bdelete<CR>'

" Turn off search highlight
nnoremap <silent><Esc><Esc>  :silent! nohlsearch<CR>

" }}}

" Open/close folding: {{{
" -----
" Toggle fold
nnoremap <CR> za
" Focus the current fold by closing all others
nnoremap <S-Return> zMza

" Smart open/close fold
nnoremap <expr> l  foldclosed('.') != -1 ? 'zo' : 'l'
xnoremap <expr> l  foldclosed(line('.')) != -1 ? 'zogv0' : 'l'

nnoremap <silent><C-_> :<C-u>call <SID>SmartFoldCloser()<CR>

function! s:SmartFoldCloser() abort
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

" Window/Tabs operation {{{
" -----
" Use 's' key as the prefix to control window/tab

" nnoremap [Window]  <Nop>
" nmap     s         [Window]

" new tab
nnoremap <silent> st  :<C-u>tabnew<CR>
" close window
nnoremap <silent> sc  :<C-u>close<CR>
" only current window
nnoremap <silent> so  :<C-u>only<CR>
" empty current buffer
" nnoremap <silent> sx  :<C-u>call <SID>BufferEmpty()<CR>
" split window horizontally
nnoremap <silent> s-  :<C-u>split<CR>
" split window virtically
nnoremap <silent> s\| :<C-u>vsplit<CR>
" equal size window
nnoremap <silent> s=   <c-w>=<CR>
" Zoom window temporary
nnoremap <silent> <Plug>(my-zoom-window) :<C-u>call <SID>ToggleWindowZoom()<CR>
nmap     <silent> sz   <Plug>(my-zoom-window)

" " Move windown with TAB
" nnoremap <silent> <Tab>    <C-w>w
" nnoremap <silent> <S-Tab>  <C-w>W

" Resize window by Shift+arrow
nnoremap <S-Left>   <C-w><
nnoremap <S-Right>  <C-w>>
nnoremap <S-Up>     <C-w>+
nnoremap <S-Down>   <C-w>-

" " Empty buffer contents
" function! s:BufferEmpty()
"   let l:current = bufnr('%')
"   if ! getbufvar(l:current, '&modified')
"     enew
"     silent! execute 'bdelete '.l:current
"   endif
" endfunction

" Toggle window zoom
"  <C-w>z      : maximize current window
"  <C-w>z again: restore the previous windows
function! s:ToggleWindowZoom() abort
  if exists('t:zoom_winrestcmd')
    execute t:zoom_winrestcmd
    unlet t:zoom_winrestcmd
  else
    let t:zoom_winrestcmd = winrestcmd()
    resize
    vertical resize
  endif
endfunction
" }}}

" Leader mappings {{{

" ;; to :
" nnoremap <silent><Leader>;  :

" Quit
nnoremap <silent><Leader>q  :quit<CR>
vnoremap <silent><Leader>q  <ESC>:quit<CR>
nnoremap <silent><Leader>Q  :qall!<CR>
vnoremap <silent><Leader>Q  <ESC>:qall!<CR>

" Fast saving
nnoremap <silent><Leader>w  :update<CR>
vnoremap <silent><Leader>w  <ESC>:update<CR>
nnoremap <silent><Leader>W  :wall!<CR>
vnoremap <silent><Leader>W  <ESC>:wall!<CR>

" Toggle editor visuals
nnoremap <silent><Leader>tc  :setlocal cursorcolumn!<CR>
nnoremap <silent><Leader>tl  :setlocal cursorline!<CR>
nnoremap <silent><Leader>tn  :setlocal number!<CR>
nnoremap <silent><Leader>tr  :setlocal relativenumber!<CR>
nnoremap <silent><Leader>th  :setlocal nolist!<CR>
nnoremap <silent><Leader>tp  :setlocal paste!<CR>
nnoremap <silent><Leader>ts  :setlocal spell!<CR>
nnoremap <silent><Leader>tw  :setlocal wrap! breakindent!<CR>

" }}}

"-----------------------------------------------------------------------------
" vim: foldmethod=marker
