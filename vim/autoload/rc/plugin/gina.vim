function! rc#plugin#gina#hook_add() abort
  nnoremap <Space>gs :<C-u>Gina status<CR>
  nnoremap <Space>gb :<C-u>Gina branch<CR>
  nnoremap <Space>gc :<C-u>Gina commit<CR>
  nnoremap <Space>gl :<C-u>Gina log<CR>

  let g:lmap.g.s = ['Gina status', 'Git status']
  let g:lmap.g.b = ['Gina branch', 'Git branch']
  let g:lmap.g.c = ['Gina commit', 'Git commit']
  let g:lmap.g.l = ['Gina log', 'Git log']
endfunction

function! rc#plugin#gina#hook_post_source() abort
  " Set default options for commands
  call gina#custom#command#option('status', '--opener', 'split')
  call gina#custom#command#option('commit', '-v|--verbose')
  call gina#custom#command#option('branch', '-v', 'v')
  call gina#custom#command#option('/\%(log\|reflog\)', '--opener', 'vsplit')
  call gina#custom#command#option(
        \ '/\%(branch\|changes\|grep\|log\)',
        \ '--opener', 'vsplit'
        \)

	call gina#custom#command#option('/\%(status\|commit\)', '-u|--untracked-files')
	call gina#custom#command#option('/\%(status\|changes\)', '--ignore-submodules')

  " Custom aliases
	call gina#custom#action#alias('branch', 'track', 'checkout:track')

	call gina#custom#action#alias('branch', 'merge', 'commit:merge')

	call gina#custom#action#alias('branch', 'rebase', 'commit:rebase')

  " Custom key mappings
  call gina#custom#mapping#nmap(
        \ 'status', '<C-c><C-c>', ':<C-u>Gina commit<CR>',
        \ {'noremap': 1, 'silent': 1}
        \)

  call gina#custom#mapping#nmap(
        \ 'status', 'q', ':quit<CR>',
        \ {'noremap': 1, 'silent': 1}
        \)

	call gina#custom#mapping#nmap(
	      \ 'branch', 'g<CR>',
	      \ '<Plug>(gina-commit-checkout-track)'
	      \)

	call gina#custom#execute(
	      \ '/\%(status\|branch\|ls\|grep\|changes\|tag\)',
	      \ 'setlocal winfixheight',
	      \)
endfunction
