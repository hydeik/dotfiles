function! s:languageclient_config() abort
  nnoremap <buffer> <silent> gd    :<C-u>call LanguageClient#textDocument_definition()<CR>
  nnoremap <buffer> <silent> K     :<C-u>call LanguageClient#textDocument_hover()<CR>
  nnoremap <buffer> <silent> <F2>  :<C-u>call LanguageClient#textDocument_rename()<CR>

  " localleader mapping
  nnoremap <buffer>[LSP] <Nop>
  nmap     <buffer><LocalLeader>l  [LSP]

  nnoremap <buffer>[LSP]m  :<C-u>call LanguageClient_contextMenu()<CR>
  nnoremap <buffer>[LSP]d  :<C-u>call LanguageClient#textDocument_definition()<CR>
  nnoremap <buffer>[LSP]h  :<C-u>call LanguageClient#textDocument_hover()<CR>
  nnoremap <buffer>[LSP]R  :<C-u>call LanguageClient#textDocument_rename()<CR>
  nnoremap <buffer>[LSP]f  :<C-u>call LanguageClient#textDocument_formatting()<CR>
  nnoremap <buffer>[LSP]t  :<C-u>call LanguageClient#textDocument_typeDefinition()<CR>
  nnoremap <buffer>[LSP]a  :<C-u>call LanguageClient_workspacce_applyEdit()<CR>
  " LanguageClient also provides Denite sources
  nnoremap <buffer>[LSP]s  :<C-u>Denite -auto-preview -mode=normal documentSymbol<CR>
  nnoremap <buffer>[LSP]S  :<C-u>Denite -auto-preview workspaceSymbol<CR>
  nnoremap <buffer>[LSP]r  :<C-u>Denite -auto-preview -mode=normal references<CR>

  setlocal formatexpr=LanguageClient_textDocument_rangeFormatting_sync()
  setlocal cmdheight=3
endfunction

function! rc#plugin#LanguageClient#hook_source() abort
  set hidden

  " --- Language server commands
  let l:ccls_cache_dir = $XDG_CACHE_HOME . '/ccls'
  let l:ccls_arg_log_file = '--log-file=/tmp/ccls/ccls.log'
  let l:ccls_arg_init = '--init={"cacheDirectory": "' . l:ccls_cache_dir
        \ . '", "diagnostics": {"onOpen": true, "onChange": false, "onSave": true}'
        \ . ', "completion": {"filterAndSort": false}}'

  let g:LanguageClient_serverCommands = {
        \ 'c':      ['ccls', l:ccls_arg_log_file, l:ccls_arg_init],
        \ 'cpp':    ['ccls', l:ccls_arg_log_file, l:ccls_arg_init],
        \ 'python': ['pyls', '--log-file=/tmp/pyls.log'],
        \ 'rust':   ['rustup', 'run', 'nightly', 'rls'],
        \ }

  " Start LanguageClient automatically
  let g:LanguageClient_autoStart = 1

  let g:LanguageClient_loadSettings = 1
  let g:LanguageClient_settingsPath = g:vimrc_root . '/settings.json'
  " let g:LanguageClient_trace = 'verbose'

  autocmd MyVimrc FileType c,cpp,python,rust call s:languageclient_config()

  " deoplete setting
  if dein#tap('deoplete.nvim')
    call deoplete#custom#source('LanguageClient', 'min_pattern_length', 2)
  endif
endfunction
