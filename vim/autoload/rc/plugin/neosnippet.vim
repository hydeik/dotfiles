function! rc#plugin#neosnippet#hook_add() abort
  " <C-k> to insert a snippet
  imap <C-k> <Plug>(neosnippet_expand_or_jump)
  smap <C-k> <Plug>(neosnippet_expand_or_jump)
  xmap <C-k> <Plug>(neosnippet_expand_target)
endfunction

function! rc#plugin#neosnippet#hook_source() abort
  let g:neosnippet#enable_snipmate_compatibility = 1
  let g:neosnippet#enable_completed_snippet = 1
  let g:neosnippet#expand_word_boundary = 1
  let g:neosnippet#snippets_directory = g:vimrc_root . '/snippets'
endfunction
