function! rc#plugin#eskk#hook_add() abort
  imap <C-j>  <Plug>(eskk:toggle)
  cmap <C-j>  <Plug>(eskk:toggle)
endfunction

function! rc#plugin#eskk#hook_source() abort
  " --- eskk directory
  let g:eskk#directory = expand('$VIM_CACHE_HOME/eskk')

  " --- user dictionary
  let g:eskk#dictionary = {
    \ 'path': expand('$VIM_CACHE_HOME/skk-jisyo'),
    \ 'sorted': 1,
    \ 'encoding': 'utf-8',
    \ }

  " --- large dictionary
  if has('mac')
    let g:eskk#large_dictionary = {
      \ 'path': '~/Library/Application\ Support/AquaSKK/SKK-JISYO.L',
      \ 'sorted': 1,
      \ 'encoding': 'euc-jp',
      \ }
  elseif has('win32') || has('win64')
    let g:eskk#large_dictionary = {
      \ 'path': '~/SKK-JISYO.L',
      \ 'sorted': 1,
      \ 'encoding': 'euc-jp',
      \ }
  else
    let g:eskk#large_dictionary = {
      \ 'path': '/usr/local/share/skk/SKK-JISYO.L',
      \ 'sorted': 1,
      \ 'encoding': 'euc-jp',
      \ }
  endif

  " --- SKK server
  let g:eskk#server = {
      \ 'host': 'localhost',
      \ 'port': 1178,
      \ }

  " --- Henkan, annotation
  let g:eskk#show_annotation = 1

  let g:eskk#keep_state = 0
  let g:eskk#debug = 0
  let g:eskk#show_annotation = 1
  let g:eskk#egg_like_newline = 1
  let g:eskk#egg_like_newline_completion = 1
  let g:eskk#tab_select_completion = 1
  let g:eskk#start_completion_length = 2

  " --- easy escape with 'jj'
  autocmd MyVimrc User eskk-initialize-post EskkMap -remap jj <ESC>
endfunction
