function! s:coc_config() abort
  " Completion
  call coc#config('suggest', {
        \ 'autoTrigger': 'always',
        \ 'triggerAfterInsertEnter': v:true,
        \ 'timeout': 1000,
        \ 'noselect': v:true,
        \ 'formatOnType': v:false,
        \ 'snippetIndicator': "\uf0d0",
        \ 'enablePreview': v:true,
        \ })
  " Diagnostics
  call coc#config('diagnostic', {
        \ 'enable': v:true,
        \ 'signOffset': 1000,
        \ 'errorSign': "\uf00d",
        \ 'warningSign': "\uf071",
        \ 'infoSign': "\uf05a",
        \ 'hintSign': "\uf27b",
        \ })
  " CocList
  call coc#config('list', {
        \ 'maxHeight': 15,
        \ 'autoResize': v:false,
        \ 'nextKeymap': '<C-n>',
        \ 'previousKeymap': '<C-p>',
        \ 'insertMappings': {
        \   '<M-n>': 'prompt:next',
        \   '<M-p>': 'prompt:previous',
        \   '<C-g>': 'do:cancel',
        \   },
        \ 'normalMappings': {
        \   '<M-n>': 'prompt:next',
        \   '<M-p>': 'prompt:previous',
        \   '<C-g>': 'do:cancel',
        \   'd':     'action:delete',
        \   },
        \ })

  " Language servers
  let s:languageservers = {}

  if executable('ccls')
    let s:languageservers['ccls'] = {
          \   'command': 'ccls',
          \   'filetypes': ['c', 'cpp', 'objc', 'objcpp'],
          \   'rootPatterns': ['.ccls', 'compile_commands.json',
          \                    '.vim', '.git', '.hg'],
          \   'initializationOptions': {
          \     'cacheDirectory': $XDG_CACHE_HOME.'/ccls',
          \     'diagnostics': {
          \       'onOpen': v:true,
          \       'onChange': v:false,
          \       'onSave': v:true
          \     },
          \     'completion': {
          \       'filterAndSort': v:false
          \     },
          \   }
          \ }
  endif

  if executable('bingo')
    let s:languageservers['golang'] = {
          \   'command': 'bingo',
          \   'filetypes': ['go'],
          \   'rootPatterns': ['go.mod', '.vim', '.git', '.hg'],
          \ }
  endif

  if executable('reason-language-server')
    let s:languageservers['reason'] = {
          \   'command': 'reason-language-server',
          \   'filetypes': ['reason']
          \ }
  endif

  if executable('bash-language-server')
    let s:languageservers['bash'] = {
          \   'command': 'bash-language-server',
          \   'args': ['start'],
          \   'filetypes': ['sh'],
          \   'ignoredRootPaths': ['~']
          \ }
  endif

  if executable('efm-langserver')
    let s:languageservers['efm'] = {
          \   'command': 'efm-langserver',
          \   'args': [],
          \   'filetypes': ['vim', 'eruby', 'markdown'],
          \   'ignoredRootPaths': ['~']
          \ }
  endif

  if !empty(s:languageservers)
    call coc#config('languageserver', s:languageservers)
  endif

  " Extensions
  " call coc#config('pyls', {
  "      \ 'commandPath': $PYENV_ROOT.'/versions/neovim3/bin/pyls'
  "      \ })
endfunction

" configure Coc.nvim
call s:coc_config()

" --- Custom commands
" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')
" Use `:Fold` for fold current buffer
command! -nargs=? Fold   :call CocAction('fold', <f-args>)
" Install extensions not installed yet
command! -nargs=0 CocInstallMyExtensions :call s:coc_install_my_extensions()
