function! rc#plugin#fugitive#hook_add() abort
  " fugitive mappings
  nnoremap <Leader>ga :<C-u>Gwrite<CR>
  nnoremap <Leader>gb :<C-u>Gblame<CR>
  nnoremap <Leader>gc :<C-u>Gcommit<CR>
  nnoremap <Leader>gC :<C-u>Git commit --amend<CR>
  nnoremap <Leader>gd :<C-u>Gdiff<CR>
  nnoremap <Leader>gr :<C-u>Gread<CR>
  nnoremap <Leader>gs :<C-u>Gstatus<CR>

  " vim-rhubarb mappings
  if dein#tap('vim-rhubarb')
    nnoremap <Leader>gB :<C-u>Gbrowse<CR>
  endif

  " gv.vim mappings
  if dein#tap('gv.vim')
    nnoremap <Leader>gv :<C-u>GV!<CR>
    nnoremap <Leader>gV :<C-u>GV<CR>
  endif
endfunction
