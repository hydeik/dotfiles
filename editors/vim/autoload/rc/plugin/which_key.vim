function! rc#plugin#which_key#hook_source() abort
  let g:which_key_leader_map = get(g:, 'which_key_leader_map', {})

  let g:which_key_leader_map['c'] = {
        \ 'name': '+comment',
        \ 'c': 'toggle comment (^)',
        \ 'a': 'toggle comment ($)',
        \ 'b': 'toggle comment (box)',
        \ 'o': 'jump to next comment',
        \ 'O': 'jump to prev comment',
        \ }

  let g:which_key_leader_map['d'] = {
        \ 'name': '+diff',
        \ 'f': 'Line diff',
        \ 'a': 'Line diff add',
        \ 's': 'Line diff show',
        \ 'r': 'Line diff reset'
        \ }

  " Register keymappings
  call which_key#register('<Space>', "g:which_key_leader_map")
  nnoremap <Leader>      :<C-u>WhichKey       '<Space>'<CR>
  vnoremap <Leader>      :<C-u>WhichKeyVisual '<Space>'<CR>

  " Hide status line when which_key popup window opens
  autocmd MyAutoCmd FileType which_key set laststatus=0 |
    \ autocmd BufLeave <buffer> set laststatus=2
endfunction
