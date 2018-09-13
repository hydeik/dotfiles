function! rc#plugin#easymotion#hook_source() abort
  " Disable default mappings
  let g:EasyMotion_do_mapping = 0
  " Do not shade
  let g:EasyMotion_do_shade = 0
  " Use uppercase target labels (and type as a lowercase)
  let g:EasyMotion_use_upper = 1
  " Characters used for target labels
  let g:EasyMotion_keys = ';HKLYUIONM,WERTXCVBASDGJF'
  " Smartcase ('v' matches both 'v' and 'V', while 'V' does only 'V')
  let g:EasyMotion_smartcase = 1
  " Smartsign ('1' matches both '1' and '!' -> not used)
  let g:EasyMotion_use_smartsign_us = 0
  " keep cursor column
  let g:EasyMotion_startofline = 0
  " Don't skip folded line
  let g:EasyMotion_skipfoldedline = 0
  " pseudo-migemo
  let g:EasyMotion_use_migemo = 1
  " Jump to first with enter & space
  let g:EasyMotion_space_jump_first = 1
  " Prompt
  let g:EasyMotion_prompt = 'Search for {n} chars> '
endfunction

function! rc#plugin#easymotion#hook_add() abort
  nmap ss <Plug>(easymotion-overwin-f2)
  vmap ss <Plug>(easymotion-s2)
  omap ss <Plug>(easymotion-s2)

  " Line jumps
  map sh <Plug>(easymotion-linebackward)
  map sj <Plug>(easymotion-j)
  map sk <Plug>(easymotion-k)
  map sl <Plug>(easymotion-lineforward)

  " smart f & F (visual mode and operator mode)
  omap f <Plug>(easymotion-bd-fl)
  xmap f <Plug>(easymotion-bd-fl)
  omap F <Plug>(easymotion-Fl)
  xmap F <Plug>(easymotion-Fl)
  omap t <Plug>(easymotion-tl)
  xmap t <Plug>(easymotion-tl)
  omap T <Plug>(easymotion-Tl)
  xmap T <Plug>(easymotion-Tl)

  " Search and jump
  map  s/ <Plug>(easymotion-sn)
  omap s/ <Plug>(easymotion-tn)
  map  sn <Plug>(easymotion-next)
  map  sp <Plug>(easymotion-prev)
endfunction
