function! rc#plugin#gina#hook_add() abort
  nnoremap <Leader>gs :<C-u>Gina status<CR>
  nnoremap <Leader>gb :<C-u>Gina branch<CR>
  nnoremap <Leader>gc :<C-u>Gina commit<CR>
  nnoremap <Leader>gl :<C-u>Gina log<CR>
endfunction

function! rc#plugin#gina#hook_post_source() abort
  " Set default options for commands
  call gina#custom#command#option('branch', '-v', 'v')
  call gina#custom#command#option('/\%(log\|reflog\)', '--opener', 'vsplit')
  call gina#custom#command#option('/\%(branch\|changes\|grep\|log\)', '--opener', 'vsplit')
  call gina#custom#command#option('log', '--group', 'log-viwer')
  call gina#custom#command#option('reflog', '--group', 'reflog-viwer')
  call gina#custom#command#option('commit', '-v|--verbose')
  call gina#custom#command#option('status', '--opener', 'split')
  call gina#custom#command#option('/\%(status\|commit\)', '-u|--untracked-files')
  call gina#custom#command#option('/\%(status\|changes\)', '--ignore-submodules')

  " Custom aliases
  call gina#custom#action#alias('branch', 'track', 'checkout:track')

  call gina#custom#action#alias('branch', 'merge', 'commit:merge')

  call gina#custom#action#alias('branch', 'rebase', 'commit:rebase')

  " Custom key mappings
  call gina#custom#mapping#nmap(
        \ 'branch', 'D',
        \ ':call gina#action#call(''branch:delete'')<CR>',
        \ {'noremap': 1, 'silent': 1}
        \ )

  call gina#custom#mapping#nmap(
        \ 'branch', 'N',
        \ ':call gina#action#call(''branch:new'')<CR>',
        \ {'noremap': 1, 'silent': 1}
        \ )

  call gina#custom#mapping#nmap(
        \ 'branch', 'm',
        \ ':call gina#action#call(''branch:move'')<CR>',
        \ {'noremap': 1, 'silent': 1}
        \ )

  call gina#custom#mapping#nmap(
        \ 'branch', 'r',
        \ ':call gina#action#call(''branch:refresh'')<CR>',
        \ {'noremap': 1, 'silent': 1}
        \ )

  call gina#custom#mapping#nmap(
        \ 'status', '<C-c><C-c>', ':<C-u>Gina commit<CR>',
        \ {'noremap': 1, 'silent': 1}
        \ )

  call gina#custom#mapping#nmap(
        \ '/\%(status\|branch\|blame\|log\|reflog\)', 'q', ':quit<CR>',
        \ {'noremap': 1, 'silent': 1}
        \ )

  call gina#custom#mapping#nmap(
        \ 'branch', 'g<CR>',
        \ '<Plug>(gina-commit-checkout-track)'
        \ )

  call gina#custom#execute(
        \ '/\%(status\|branch\|ls\|grep\|changes\|tag\)',
        \ 'setlocal winfixheight',
        \ )
endfunction
