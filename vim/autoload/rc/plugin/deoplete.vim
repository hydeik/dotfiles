function! s:my_cr_function() abort
  return deoplete#close_popup() . "\<CR>"
endfunction

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

function! rc#plugin#deoplete#hook_add() abort
endfunction

function! rc#plugin#deoplete#hook_source() abort
  " Start deoplete
  let g:deoplete#enable_at_startup = 1

  let g:deoplete#enable_refresh_always = 0
  let g:deoplete#enable_camel_case = 1
  " let g:deoplete#auto_complete_delay = 50
  " let g:deoplete#auto_complete_start_length = 3
  let g:deoplete#skip_chars = ['(', ')', '<', '>']

  let g:deoplete#file#enable_buffer_path = 1

  " Keyword patterns for buffer completion
  let g:deoplete#keyword_patterns = {}
  let g:deoplete#keyword_patterns._ = '[a-zA-Z_]\k*\(?'
  let g:deoplete#keyword_patterns.tex = '[^\w|\s][a-zA-Z_]\w*'

  " Input patterns for filetypes
  let g:deoplete#omni#input_patterns = get(g:, 'deoplete#omni#input_patterns', {})
  let g:deoplete#omni#input_patterns.xml = '<[^>]*'
  let g:deoplete#omni#input_patterns.md  = '<[^>]*'
  let g:deoplete#omni#input_patterns.css  = '^\s\+\w\+\|\w\+[):;]\?\s\+\w*\|[@!]'
  let g:deoplete#omni#input_patterns.scss = '^\s\+\w\+\|\w\+[):;]\?\s\+\w*\|[@!]'
  let g:deoplete#omni#input_patterns.sass = '^\s\+\w\+\|\w\+[):;]\?\s\+\w*\|[@!]'
  let g:deoplete#omni#input_patterns.javascript = ''
  let g:deoplete#omni#input_patterns.python = ''
  let g:deoplete#omni#input_patterns.ruby   = '[^. *\t]\.\w*\|\h\w*::'

  " omni functions
  let g:deoplete#omni#functions = get(g:, 'deoplete#omni#functions', {})

  " --- Key mappings
  " <TAB> like behavior.
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ deoplete#manual_complete()
  " <S-TAB>: completion back.
  inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<C-h>"
  " <C-h>, <BS>: close popup and delete backword char.
  inoremap <expr><C-h>  deoplete#smart_close_popup()."\<C-h>"
  inoremap <expr><BS>   deoplete#smart_close_popup()."\<C-h>"
  " inoremap <expr><C-g> deoplete#undo_completion()
  " <C-g>: refresh the candidates
  inoremap         <expr><C-g>  deoplete#refresh()
  " <C-l>: complete common string in the candidates
  inoremap <silent><expr><C-l>  deoplete#complete_common_string()
  " <CR>: close popup and save indent.
  inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
endfunction

function! rc#plugin#deoplete#hook_post_source() abort
  " Default converters
  call deoplete#custom#source('_', 'converters', [
        \ 'converter_remove_paren',
        \ 'converter_remove_overlap',
        \ 'converter_truncate_abbr',
        \ 'converter_truncate_menu',
        \ 'converter_auto_delimiter',
        \ ])
endfunction

