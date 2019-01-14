function! rc#plugin#ale#hook_add() abort
  " jump errors
  nmap <silent> <Leader>aj  <Plug>(ale_previous_wrap)
  nmap <silent> <Leader>ak  <Plug>(ale_next_wrap)
  " Fix (auto-format) the buffer
  nmap <silent> <Leader>af  <Plug>(ale_fix)
endfunction

function! rc#plugin#ale#hook_source() abort
  " Don't lint the buffer during edittting
  let g:ale_lint_on_text_changed = 'never'

  " Use global executables for all linters by default.
  let g:ale_use_global_executables = 1

  " Always show sign gutter
  let g:ale_sign_column_always = 1

  " Disable linters which conflict with LSP
  let g:ale_linters = {
        \ 'c': [],
        \ 'cpp': [],
        \ 'go': [],
        \ 'python': [],
        \ 'ruby': [],
        \ 'rust': [],
        \ 'sh': [],
        \ 'vim': ['vint'],
        \ 'css': [],
        \ 'html': [],
        \ 'javascript': [],
        \ 'typescript': [],
        \ 'json': [],
        \ 'reason': [],
        \ 'vue': [],
        \ }

  let g:ale_linters_ignore = {
        \ 'latex': ['lacheck']
        \ }

  " --- Fortran
  " extra options for warnings
  let g:ale_fortran_gcc_options = '-Wall -Wextra -Wcharacter-truncation -Wconversion-extra'
  " Free format
  let g:ale_fortran_gcc_use_free_form = 1
endfunction
