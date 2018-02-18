function! rc#plugin#caw#hook_add() abort
  map gc <Plug>(caw:hatpos:toggle:operator)
  map gcc <Plug>(caw:hatpos:toggle)
endfunction

function! rc#plugin#caw#hook_source() abort
  let g:caw_no_default_keymappings = 1
endfunction

