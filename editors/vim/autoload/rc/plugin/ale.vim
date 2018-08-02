function! rc#plugin#ale#hook_add() abort
  " jump errors
  nmap <silent> <Localleader>j  <Plug>(ale_previous_wrap)
  nmap <silent> <Localleader>k  <Plug>(ale_next_wrap)

  " Fix (auto-format) the buffer
  nmap <silent> <Localleader>lf  <Plug>(ale_fix)
endfunction

function! rc#plugin#ale#hook_source() abort
  " Don't lint the buffer during edittting
  let g:ale_lint_on_text_changed = 'never'

  " Use global executables for all linters by default.
  let g:ale_use_global_executables = 1

  " Always show sign gutter
  let g:ale_sign_column_always = 1

  " Run fixer on save (auto format)
  let g:ale_fix_on_save = 1

  " Dictionary to set linters and fixsers
  let g:ale_linters = {}
  let g:ale_fixers = {}

  " -- C/C++ options
  let g:ale_c_clang_options = '-std=c11 -Weverything'

  let g:ale_linters.c = ['clangtidy', 'clang']
  let g:ale_fixers.c  = ['clang-format']

  let g:ale_cpp_clang_options = '-std=c++14 -Weverything ' .
        \ '-Wno-c++98-compat-pedantic -Wno-missing-prototypes'

  let g:ale_linters.cpp = ['clangtidy', 'clang']
  let g:ale_fixers.cpp  = ['clang-format']

  " --- Fortran
  " extra options for warnings
  let g:ale_fortran_gcc_options = '-Wall -Wextra -Wcharacter-truncation -Wconversion-extra'
  " Free format
  let g:ale_fortran_gcc_use_free_form = 1

  " --- Python
  let g:ale_linters.python = ['pycodestyle', 'mypy']
  let g:ale_fixers.python  = ['yapf', 'isort']

  " --- Rust
  let g:ale_rust_rls_toolchain = 'stable'

  let g:ale_linters.rust = ['rls']
  let g:ale_fixers.rust  = ['rustfmt']
endfunction
