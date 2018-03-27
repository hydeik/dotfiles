" Key mappings for plugins
"-----------------------------------------------------------------------------

" dein
nnoremap <silent> <Space>up :<C-u>call dein#clear_state()<CR>:UpdateRemotePlugins<CR>
nnoremap <silent> <Space>uP :<C-u>call dein#update()<CR>

if dein#tap('denite.nvim')
  " Substitute search commands by denite
  nnoremap <silent> / :<C-u>Denite line -buffer-name=search -auto-highlight<CR>
  nnoremap <silent> * :<C-u>DeniteCursorWord line -buffer-name=search -auto-highlight -mode=normal<CR>
  " Substitute 'n' command
  nnoremap <silent> n :<C-u>Denite -resume -buffer-name=search -auto-highlight -mode=normal -refresh<CR>

  " Press <Leader> twice to call a command or command history
  nnoremap <silent> <Space><Space> :<C-u>Denite command command_history<CR>

  " -- B mapping
  nnoremap <silent> <Space>bb :<C-u>Denite -mode=normal buffer<CR>
  nnoremap <silent> <Space>bf :<C-u>DeniteBufferDir file_rec -mode=insert<CR>
  nnoremap <silent> <Space>bF :<C-u>DeniteBufferDir file -mode=normal<CR>
  " Grep current buffer
  nnoremap <silent> <Space>bg :<C-u>DeniteBufferDir -buffer-name=search -no-empty -mode=normal grep<CR>
  xnoremap <silent> <Space>bg :<C-u>DeniteBufferDir grep:::`GetVisualSelectionESC()` -no-empty<CR>
  nnoremap <silent> <Space>bG :<C-u>DeniteBufferDir grep:::`expand('<cword>')` -no-empty<CR>

  " -- D mapping
  nnoremap <silent> <Space>dg :<C-u>Denite ghq<CR>
  nnoremap <silent> <Space>dh :<C-u>Denite help<CR>
  nnoremap <silent> <Space>dj :<C-u>Denite jump change<CR>
  nnoremap <silent> <Space>do :<C-u>Denite outline<CR>
  nnoremap <silent> <Space>dp :<C-u>Denite dein -default-action=open<CR>
  nnoremap <silent> <Space>dr :<C-u>Denite -resume<CR>
  nnoremap <silent> <Space>ds :<C-u>Denite session -buffer-name=list<CR>
  nnoremap <silent> <Space>dt :<C-u>Denite tag<CR>

  " -- F mapping
  nnoremap <silent> <Space>ff :<C-u>Denite file_rec -path=`getcwd()`<CR>
  nnoremap <silent> <Space>fF :<C-u>Denite file -path=`getcwd()`<CR>
  nnoremap <silent> <Space>fd :<C-u>Denite file_rec -path=`g:vimrc_root`<CR>
  nnoremap <silent> <Space>fr :<C-u>Denite file_mru<CR>
  nnoremap <silent> <Space>fs :<C-u>call save_file(0)<CR>
  nnoremap <silent> <Space>fS :<C-u>call save_file(1)<CR>
  nnoremap <silent> <Space>ft :<C-u>Denite filetype<CR>

  " -- J mapping
  nnoremap <silent> <Space>jl :<C-u>Denite jump change<CR>

  " -- P mapping
  nnoremap <silent> <Space>pf :<C-u>DeniteProjectDir file_rec<CR>
  nnoremap <silent> <Space>pF :<C-u>DeniteProjectDir file<CR>
  nnoremap <silent> <Space>pg :<C-u>DeniteProjectDir -buffer-name=search -no-empty -mode=normal grep<CR>
  xnoremap <silent> <Space>pg :<C-u>DeniteProjectDir -buffer-name=search -no-empty grep:::`GetVisualSelectionESC()`<CR>
  nnoremap <silent> <Space>pG :<C-u>DeniteProjectDir -buffer-name=search -no-empty grep:::`expand('<cword>')`<CR>

  " -- S mapping
  nnoremap <silent> <Space>sl :<C-u>Dentie session<CR>

  " -- Y mapping
  nnoremap <silent> <Space>yy :<C-u>Denite -buffer-name=register register neoyank<CR>
  xnoremap <silent> <Space>yy :<C-u>Denite -default-action=replace -buffer-name=register register neoyank<CR>

  " Save function
  function! s:save_file(force)
    let l:cmd = &readonly ? 'SudoWrite' : a:force ? 'w!' : 'w'
    execute l:cmd
  endfunction
endif

if dein#tap('neosnippet')
  " <C-k> to insert a snippet
  imap <C-k> <Plug>(neosnippet_expand_or_jump)
  smap <C-k> <Plug>(neosnippet_expand_or_jump)
  xmap <C-k> <Plug>(neosnippet_expand_target)
endif

if dein#tap('vim-easy-align')
  vnoremap <Enter> :EasyAlign<CR>
endif

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

if dein#tap('vim-indent-guides')
  nmap <silent><Leader>ti :<C-u>IndentGuidesToggle<CR>
endif

if dein#tap('vim-bookmarks')
	nmap ma :<C-u>cgetexpr bm#kocation_list()<CR> :<C-u>Denite quickfix -buffer-name=list<CR>
	nmap mn <Plug>BookmarkNext
	nmap mp <Plug>BookmarkPrev
	nmap mm <Plug>BookmarkToggle
  nmap mi <Plug>BookmarkAnnotate
endif

if dein#tap('caw.vim')
  nmap <silent> gc  <Plug>(caw:prefix)
  xmap <silent> gc  <Plug>(caw:prefix)
  nmap <silent> gcc <Plug>(caw:hatpos:toggle)
  xmap <silent> gcc <Plug>(caw:hatpos:toggle)
endif

if dein#tap('gina.vim')
  nnoremap <Space>gs :<C-u>Gina status<CR>
  nnoremap <Space>gb :<C-u>Gina branch<CR>
  nnoremap <Space>gc :<C-u>Gina commit<CR>
  nnoremap <Space>gl :<C-u>Gina log<CR>

  let g:lmap.g.s = ['Gina status', 'Git status']
  let g:lmap.g.b = ['Gina branch', 'Git branch']
  let g:lmap.g.c = ['Gina commit', 'Git commit']
  let g:lmap.g.l = ['Gina log', 'Git log']
endif

if dein#tap('session.vim')
  nnoremap <Space>ss :<C-u>SessionSave<CR>
  nnoremap <Space>sl :<C-u>Denite session -mode=normal<CR>
  nnoremap <Space>so :<C-u>SessionOpen<CR>
  nnoremap <Space>sc :<C-u>SessionClose<CR>
  nnoremap <Space>sd :<C-u>SessionRemove<CR>

  let g:lmap.s.s = ['SessionSave', 'Session save']
  let g:lmap.s.o = ['SessionOpen', 'Session open']
  let g:lmap.s.c = ['SessionClose', 'Session close']
  let g:lmap.s.d = ['SessionRemove', 'Session remove']
  let g:lmap.s.l = ['Denite session -mode=normal', 'Denite session']
endif

if dein#tap('accelerated-jk')
  nmap <silent>j <Plug>(accelerated_jk_gj)
  nmap <silent>k <Plug>(accelerated_jk_gk)
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
  " register it with the guide:
  call leaderGuide#register_prefix_descriptions("<Space>", "g:lmap")
  call leaderGuide#register_prefix_descriptions(",", "g:llmap")

  nnoremap <silent> <Space>  :<C-u>LeaderGuide       '<Space>'<CR>
  vnoremap <silent> <Space>  :<C-u>LeaderGuideVisual '<Space>'<CR>
  map               <Space>.  <Plug>leaderguide-global
  map               <Space>,  <Plug>leaderguide-buffer
endif
