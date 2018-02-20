function! rc#plugin#LanguageClient#hook_source() abort
  set hidden
  let g:LanguageClient_autoStart = 1

  " Language servers
  let g:LanguageClient_serverCommands = {
        \ 'c':   ['/usr/local/opt/llvm/bin/clangd'],
        \ 'cpp': ['/usr/local/opt/llvm/bin/clangd'],
        \ 'python': [$PYENV_ROOT . '/versions/neovim3/bin/pyls'],
        \ 'rust': ['rustup', 'run', 'stable', 'rls'],
        \ }

  let g:LanguageClient_loadSettings = 1
  let g:LanguageClient_settingsPath = g:vimrc_root . '/settings.json'

  set formatexpr=LanguageClient_textDocument_rangeFormatting()
endfunction

function! rc#plugin#LanguageClient#hook_add() abort
  nnoremap <Leader>ld  :call LanguageClient_textDocument_definition()<CR>
  nnoremap <Leader>ls  :call LanguageClient_textDocument_documentSymbol()<CR>
  nnoremap <Leader>lr  :call LanguageClient_textDocument_rename()<CR>
  nnoremap <Leader>lR  :call LanguageClient_textDocument_references()<CR>
  " Search for workspace symbols approximately.
  nnoremap <Leader>la  :call LanguageClient_workspace_symbol({'query':input('workspace/symbol ')})<CR>
  " nnoremap <silent> gd  :call LanguageClient_textDocument_denifinition()<CR>
  " nnoremap <silent> <F2>  :call LanguageClient_textDocument_rename()<CR>

  " Denite source
  nnoremap <silent>;ls :Denite -mode=normal documentSymbol<CR>
  nnoremap <silent>;lS :Denite -mode=normal workspaceSymbol<CR>
  nnoremap <silent>;lr :Denite -mode=normal reference<CR>


  augroup LanguageClient_config
    autocmd!
    autocmd BufEnter * let b:Plugin_LanguageClient_started = 0
    autocmd User LanguageClientStarted setlocal signcolumn=yes
    autocmd User LanguageClientStarted let b:Plugin_LanguageClient_started = 1
    autocmd User LanguageClientStopped setlocal signcolumn=auto
    autocmd User LanguageClientStopped let b:Plugin_LanguageClient_stopped = 0
    " Send textDocument/hover when cursor moves.
    autocmd CursorMoved * if b:Plugin_LanguageClient_started | call LanguageClient_textDocument_hover() | endif
    " auto format buffer on save
    autocmd BufWrite,FileWritePre,FileAppendPre *
        \ if b:Plugin_LanguageClient_started | call LanguageClient_textDocument_formatting() | endif
  augroup END
endfunction
