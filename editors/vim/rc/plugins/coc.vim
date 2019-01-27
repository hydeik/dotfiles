" List of coc-extensions to be instalBufEnterled
let s:coc_extension_list = [
      \ 'coc-css',
      \ 'coc-emmet',
      \ 'coc-emoji',
      \ 'coc-eslint',
      \ 'coc-html',
      \ 'coc-json',
      \ 'coc-neosnippet',
      \ 'coc-prettier',
      \ 'coc-pyls',
      \ 'coc-rls',
      \ 'coc-tsserver',
      \ 'coc-vetur',
      \ 'coc-word',
      \ 'coc-yaml'
      \ ]

function! s:coc_install_my_extensions() abort
  " Get list of installed extensions
  let list = map(CocAction('extensionStats'), 'v:val["id"]')
  let missing = filter(s:coc_extension_list, 'index(list, v:val) < 0')
  if !empty(missing)
    call coc#util#install_extension(join(missing))
  endif
endfunction

" --- Custom commands
" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')
" Use `:Fold` for fold current buffer
command! -nargs=? Fold   :call CocAction('fold', <f-args>)
" Install extensions not installed yet
command! -nargs=0 CocInstallMyExtensions :call s:coc_install_my_extensions()
