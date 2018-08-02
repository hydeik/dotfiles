function! rc#plugin#easymotion#hook_source() abort
  let g:EasyMotion_do_mapping = 0
  let g:EasyMotion_keys = ';HKLYUIONM,WERTXCVBASDGJF'
  " Do not shade
  let g:EasyMotion_do_shade = 0
  " Use upper case
  let g:EasyMotion_use_upper = 1
  " Smartcase
  let g:EasyMotion_smartcase = 1
  " Smartsign
  let g:EasyMotion_use_smartsign_us = 1
  " keep cursor column
  let g:EasyMotion_startofline = 0
  " Don't skip folded line
  let g:EasyMotion_skipfoldedline = 0
  " pseudo-migemo
  let g:EasyMotion_use_migemo = 1
  " Jump to first with enter & space
  let g:EasyMotion_space_jump_first = 1
  " Prompt
  let g:EasyMotion_prompt = '{n}> '
endfunction

function! rc#plugin#easymotion#hook_add() abort
  nmap ss <Plug>(easymotion-overwin-f2)
  vmap ss <Plug>(easymotion-s2)
  omap ss <Plug>(easymotion-s2)

  " smart f & F
  omap f <Plug>(easymotion-bd-fl)
  xmap f <Plug>(easymotion-bd-fl)

  " Search and jump
  map  s/ <Plug>(easymotion-sn)
  omap s/ <Plug>(easymotion-tn)
  map  sn <Plug>(easymotion-next)
  map  sp <Plug>(easymotion-prev)

  " omap F <Plug>(easymotion-Fl)
  " xmap F <Plug>(easymotion-Fl)
  " omap t <Plug>(easymotion-tl)
  " xmap t <Plug>(easymotion-tl)
  " omap T <Plug>(easymotion-Tl)
  " xmap T <Plug>(easymotion-Tl)

  " " hjkl
  " map ;h <Plug>(easymotion-linebackward)
  " map ;j <Plug>(easymotion-j)
  " map ;k <Plug>(easymotion-k)
  " map ;l <Plug>(easymotion-lineforward)
endfunction
