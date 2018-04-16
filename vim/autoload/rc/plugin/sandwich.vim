function! rc#plugin#sandwich#hook_add() abort
  silent! nmap <unique><silent> sd <Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)
  silent! nmap <unique><silent> sr <Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)
  silent! nmap <unique><silent> sdb <Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)
  silent! nmap <unique><silent> srb <Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)

  " operator
  silent! nmap <unique> sa <Plug>(operator-sandwich-add)
  silent! xmap <unique> sa <Plug>(operator-sandwich-add)
  silent! omap <unique> sa <Plug>(operator-sandwich-g@)

  silent! xmap <unique> sd <Plug>(operator-sandwich-delete)

  silent! xmap <unique> sr <Plug>(operator-sandwich-replace)

  " textobj
  silent! omap <unique> ib <Plug>(textobj-sandwich-auto-i)
  silent! xmap <unique> ib <Plug>(textobj-sandwich-auto-i)
  silent! omap <unique> ab <Plug>(textobj-sandwich-auto-a)
  silent! xmap <unique> ab <Plug>(textobj-sandwich-auto-a)

  silent! omap <unique> is <Plug>(textobj-sandwich-query-i)
  silent! xmap <unique> is <Plug>(textobj-sandwich-query-i)
  silent! omap <unique> as <Plug>(textobj-sandwich-query-a)
  silent! xmap <unique> as <Plug>(textobj-sandwich-query-a)
endfunction

function! rc#plugin#sandwich#hook_source() abort
  let g:textobj#sandwich#stimeoutlen = 100

  " Custom recipes
  let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)
  let g:sandwich#recipes += [{'buns' : ['「', '」']}]
  let g:sandwich#recipes += [{'buns' : ['【', '】']}]
  let g:sandwich#recipes += [{'buns' : ['（', '）']}]
  let g:sandwich#recipes += [{'buns' : ['『', '』']}]

  " \(, \) pair and \%(, \) pair in Vim script
  let g:sandwich#recipes += [
        \ {'buns' : ['\(', '\)'],  'filetype' : ['vim'], 'nesting' : 1},
        \ {'buns' : ['\%(', '\)'], 'filetype' : ['vim'], 'nesting' : 1},
        \ ]
endfunction
