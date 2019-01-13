"-----------------------------------------------------------------------------
" ~/.config/nvim/rc/mapping.vim --- setting vim/nvim key mappings

" Disable dangerous/annoying default mappings
"   ZZ - Save current file and quit
"   ZQ - Quit without checking changes (:q!)
nnoremap ZZ  <Nop>
nnoremap ZQ  <Nop>

" Disable Ex-mode
nnoremap Q  <Nop>

" Useless command. M - to middle line of window
nnoremap M  m

" Y: yank text from cursor position to the EOL
nnoremap Y y$

" Better x
nnoremap x "_x

" Emacs-like cursor move in insert/command mode
inoremap <C-a>    <Home>
inoremap <C-b>    <Left>
inoremap <C-d>    <Del>
inoremap <C-e>    <End>
inoremap <C-f>    <Right>

cnoremap <C-a>    <Home>
cnoremap <C-b>    <Left>
cnoremap <C-d>    <Del>
cnoremap <C-e>    <End>
cnoremap <C-f>    <Right>
cnoremap <C-n>    <Down>
cnoremap <C-p>    <Up>

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

" Open/close folding: "{{{
" -----
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

" Window/Tabs operation {{{
" -----
" Use 's' key as the prefix to control window/tab
" The prefix key.
nnoremap [Window]  <Nop>
nmap     s         [Window]

" new tab
nnoremap <silent> [Window]t  :<C-u>tabnew<CR>
" close window
nnoremap <silent> [Window]c  :<C-u>close<CR>
" only current window
nnoremap <silent> [Window]o  :<C-u>only<CR>
" split window horizontally
nnoremap <silent> [Window]-  :<C-u>split<CR>
" split window virtically
nnoremap <silent> [Window]\| :<C-u>vsplit<CR>
" equal size window
nnoremap <silent> [Window]=   <c-w>=<CR>

" Move windown with TAB
nnoremap <silent> <Tab>    <C-w>w
nnoremap <silent> <S-Tab>  <C-w>W

" Resize window by Shift+arrow
nnoremap <S-Left>   <C-w><
nnoremap <S-Right>  <C-w>>
nnoremap <S-Up>     <C-w>+
nnoremap <S-Down>   <C-w>-

" Zoom window temporary
nnoremap <silent> <Plug>(my-zoom-window) :<C-u>call <SID>toggle_window_zoom()<CR>
nmap     <silent> [Window]z   <Plug>(my-zoom-window)

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
" }}}

" Leader mappings {{{
let g:which_key_leader_map = get(g:, 'which_key_leader_map', {})

" Fast save
nnoremap <silent><Leader>w  :write<CR>
vnoremap <silent><Leader>w  <ESC>:write<CR>

" Buffer delete
nnoremap <silent><Leader>q  :bdelete<CR>
vnoremap <silent><Leader>q  <ESC>:bdelete<CR>
nnoremap <silent><Leader>Q  :<C-u>qall!<CR>
vnoremap <silent><Leader>Q  <ESC>:<C-u>qall!<CR>

" Toggle editor visuals
nnoremap <silent> <Leader>ts  :setlocal spell!<CR>
nnoremap <silent> <Leader>tn  :setlocal number! relativenumber!<CR>
nnoremap <silent> <Leader>tl  :setlocal nolist!<CR>
nnoremap <silent> <Leader>tw  :setlocal wrap! breakindent!<CR>
nnoremap <silent> <Leader>th  :nohlsearch<CR>

let g:which_key_leader_map = get(g:, 'which_key_leader_map', {})

let g:which_key_leader_map.b = 'buffer list'
let g:which_key_leader_map.q = 'close'
let g:which_key_leader_map.Q = 'quit all'
let g:which_key_leader_map.w = 'save file'
let g:which_key_leader_map['t'] = {
      \ 'name': '+toggle',
      \ 'n': 'toggle line number',
      \ 'h': 'clear highlight',
      \ 'l': 'toggle list mode',
      \ 'p': 'toggle paste mode',
      \ 's': 'toggle spell checker',
      \ 'w': 'toggle text wrap',
      \ }

" }}}

"-----------------------------------------------------------------------------
" vim: foldmethod=marker
