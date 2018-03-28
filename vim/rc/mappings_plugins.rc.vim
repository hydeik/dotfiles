" Key mappings for plugins
"-----------------------------------------------------------------------------

" dein
nnoremap <silent> <Space>up :<C-u>call dein#clear_state()<CR>:UpdateRemotePlugins<CR>
nnoremap <silent> <Space>uP :<C-u>call dein#update()<CR>

if dein#tap('vim-textobj-multiblock')
	omap <silent> ab  <Plug>(textobj-multiblock-a)
	omap <silent> ib  <Plug>(textobj-multiblock-i)
	xmap <silent> ab  <Plug>(textobj-multiblock-a)
	xmap <silent> ib  <Plug>(textobj-multiblock-i)
endif

if dein#tap('vim-textobj-function')
  omap <silent> af  <Plug>(textobj-function-a)
	omap <silent> if  <Plug>(textobj-function-i)
	xmap <silent> af  <Plug>(textobj-function-a)
	xmap <silent> if  <Plug>(textobj-function-i)
endif

if dein#tap('vim-operator-surround')
  " operator mappings
  map <silent>sa <Plug>(operator-surround-append)
  map <silent>sd <Plug>(operator-surround-delete)
  map <silent>sr <Plug>(operator-surround-replace)

  " delete or replace most inner surround
  nmap <silent>saa <Plug>(operator-surround-append)<Plug>(textobj-multiblock-i)
  nmap <silent>sdd <Plug>(operator-surround-delete)<Plug>(textobj-multiblock-a)
  nmap <silent>srr <Plug>(operator-surround-replace)<Plug>(textobj-multiblock-a)
endif

if dein#tap('vim-operator-replace')
  xmap p  <Plug>(operator-replace)
endif

if dein#tap('vim-operator-flashy')
  map  y  <Plug>(operator-flashy)
  nmap Y  <Plug>(operator-flashy)$
endif

if dein#tap('dsf.vim')
	nmap dsf  <Plug>DsfDelete
	nmap csf  <Plug>DsfChange
endif

if dein#tap('vim-edgemotion')
  map  gj  <Plug>(edgemotion-j)
  map  gk  <Plug>(edgemotion-k)
  xmap gj  <Plug>(edgemotion-j)
  xmap gk  <Plug>(edgemotion-k)
endif

if dein#tap('vim-quickhl')
  nmap <Leader>, <Plug>(quickhl-manual-this)
  xmap <Leader>, <Plug>(quickhl-manual-this)
endif

if dein#tap('vim-sidemenu')
  nmap <Leader>l <Plug>(sidemenu)
  xmap <Leader>l <Plug>(sidemenu-visual)
endif

if dein#tap('vim-bookmarks')
	nmap ma :<C-u>cgetexpr bm#location_list()<CR> :<C-u>Denite quickfix -buffer-name=list<CR>
	nmap mn <Plug>BookmarkNext
	nmap mp <Plug>BookmarkPrev
	nmap mm <Plug>BookmarkToggle
  nmap mi <Plug>BookmarkAnnotate
endif

if dein#tap('vim-gitgutter')
  nmap <silent> <Space>gk  <Plug>GitGutterPrevHunkzz
  nmap <silent> <Space>gj  <Plug>GitGutterNextHunkzz
  nmap <silent> <Space>gp  <Plug>GitGutterNextHunkzz
endif

if dein#tap('vim-qfreplace')
  autocmd MyVimrc FileType qf nnoremap <buffer> r :<C-u>Qfreplace<CR>
endif

if dein#tap('vaffle.vim')
  function! s:customize_vaffle_mappings() abort
    " Customize key mappings here
    nmap <buffer> <Bslash> <Plug>(vaffle-open-root)
    nmap <buffer> l        <Plug>(vaffle-open-selected)
  endfunction

  nnoremap <silent> <Space>fe :<C-u>Vaffle<CR>
  autocmd MyVimrc FileType vaffle call s:customize_vaffle_mappings()
endif

if dein#tap('vim-expand-region')
  xmap v  <Plug>(expand_region_expand)
  xmap V  <Plug>(expand_region_shrink)
endif

if dein#tap('eskk.vim')
  imap <C-x>j  <Plug>(eskk:toggle)
  cmap <C-x>j  <Plug>(eskk:toggle)
endif

if dein#tap('python_match.vim')
  nmap <buffer> {{ [%
  nmap <buffer> }} ]%
endif

if dein#tap('sideways.vim')
  nnoremap <silent> m" :<C-u>SidewaysJumpLeft<CR>
  nnoremap <silent> m' :<C-u>SidewaysJumpRight<CR>
  omap <silent> aa <Plug>SidewaysArgumentTextobjA
  xmap <silent> aa <Plug>SidewaysArgumentTextobjA
  omap <silent> ia <Plug>SidewaysArgumentTextobjI
  xmap <silent> ia <Plug>SidewaysArgumentTextobjI
endif

if dein#tap('vim-leader-guide')
  function! s:my_displayfunc()
    let g:leaderGuide#displayname =
          \ substitute(g:leaderGuide#displayname, '\c<cr>$', '', '')
    let g:leaderGuide#displayname =
          \ substitute(g:leaderGuide#displayname, '^<Plug>', '', '')
    let g:leaderGuide#displayname =
          \ substitute(g:leaderGuide#displayname, '^:\c<C-u>', ':', '')
  endfunction

  let g:leaderGuide_displayfunc = [function("s:my_displayfunc")]
  " register it with the guide:
  call leaderGuide#register_prefix_descriptions("<Space>", "g:lmap")
  call leaderGuide#register_prefix_descriptions(",", "g:llmap")

  nnoremap <silent> <Space>  :<C-u>LeaderGuide       '<Space>'<CR>
  vnoremap <silent> <Space>  :<C-u>LeaderGuideVisual '<Space>'<CR>
  map               <Space>.  <Plug>leaderguide-global
  map               <Space>,  <Plug>leaderguide-buffer
endif
