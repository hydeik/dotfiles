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
      \ 'objcpp': [],
      \ 'fortran': [],
      \ 'go': [],
      \ 'python': [],
      \ 'ruby': [],
      \ 'rust': [],
      \ 'sh': [],
      \ 'vim': [],
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

" " --- Fortran
" " extra options for warnings
" let g:ale_fortran_gcc_options = '-Wall -Wextra -Wcharacter-truncation -Wconversion-extra'
" " Free format
" let g:ale_fortran_gcc_use_free_form = 1
