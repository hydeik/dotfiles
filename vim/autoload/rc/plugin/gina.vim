function! rc#plugin#gina#hook_add() abort
  nnoremap <Leader>gs :<C-u>Gina status<CR>
  nnoremap <Leader>gb :<C-u>Gina branch<CR>
  nnoremap <Leader>gc :<C-u>Gina commit<CR>
  nnoremap <Leader>gl :<C-u>Gina log<CR>
endfunction

function! rc#plugin#gina#hook_post_source() abort
  " Set default options for commands
  call gina#custom#command#option('status', '--opener', 'split')
  call gina#custom#command#option('commit', '--verbose')
  call gina#custom#command#option(
    \ '/\%(branch\|changes\|grep\|log\)',
    \ '--opener', 'vsplit'
    \)
  " execute :Gina commit with '<C-c><C-c>' on gina-status buffer
  call gina#custom#mapping#nmap(
    \ 'status', '<C-c><C-c>', ':<C-u>Gina commit<CR>',
    \ {'noremap': 1, 'silent': 1}
    \)
  " quit gina-status buffer with 'q'
  call gina#custom#mapping#nmap(
    \ 'status', 'q', ':quit<CR>',
    \ {'noremap': 1, 'silent': 1}
    \)
endfunction
