function! s:languageclient_config() abort
  nnoremap <buffer> <silent> <Leader>l  :<C-u>call LanguageClient_contextMenu()<CR>
  nnoremap <buffer> <silent> gd    :<C-u>call LanguageClient#textDocument_definition()<CR>
  nnoremap <buffer> <silent> K     :<C-u>call LanguageClient#textDocument_hover()<CR>
  nnoremap <buffer> <silent> <F2>  :<C-u>call LanguageClient#textDocument_rename()<CR>

  " " localleader mapping
  " nnoremap <buffer> <LocalLeader>ld  :<C-u>call LanguageClient#textDocument_definition()<CR>
  " nnoremap <buffer> <LocalLeader>lh  :<C-u>call LanguageClient#textDocument_hover()<CR>
  " nnoremap <buffer> <LocalLeader>lR  :<C-u>call LanguageClient#textDocument_rename()<CR>
  " " LanguageClient also provides Denite sources
  " nnoremap <buffer> <LocalLeader>ls  :<C-u>Denite -auto-preview -mode=normal documentSymbol<CR>
  " nnoremap <buffer> <LocalLeader>lS  :<C-u>Denite -auto-preview workspaceSymbol<CR>
  " nnoremap <buffer> <LocalLeader>lr  :<C-u>Denite -auto-preview -mode=normal references<CR>

  setlocal formatexpr=LanguageClient_textDocument_rangeFormatting()
  setlocal cmdheight=3
endfunction

function! rc#plugin#LanguageClient#hook_source() abort
  set hidden
  let g:LanguageClient_autoStart = 1

  " --- Language servers
  let l:cquery_cache_dir = $XDG_CACHE_HOME . '/cquery'
  let l:cquery_arg_log_file = '--log-file=/tmp/cquery/cquery.log'
  let l:cquery_arg_init = '--init={"cacheDirectory": "' . l:cquery_cache_dir
        \ . '", "completion": {"filterAndSort": false}}'
  let g:LanguageClient_serverCommands = {
        \ 'c':      ['cquery', l:cquery_arg_log_file, l:cquery_arg_init],
        \ 'cpp':    ['cquery', l:cquery_arg_log_file, l:cquery_arg_init],
        \ 'python': ['pyls', '--log-file=/tmp/pyls.log'],
        \ 'rust':   ['rustup', 'run', 'stable', 'rls'],
        \ 'sh':     ['bash-language-server'],
        \ }

  let g:LanguageClient_loadSettings = 1
  let g:LanguageClient_settingsPath = g:vimrc_root . '/settings.json'
  " let g:LanguageClient_trace = 'verbose'

  autocmd MyVimrc FileType c,cpp,python,rust,sh call s:languageclient_config()

  " deoplete setting
  if dein#tap("deoplete.nvim")
    call deoplete#custom#source('LanguageClient', 'min_pattern_length', 2)
  endif
endfunction
