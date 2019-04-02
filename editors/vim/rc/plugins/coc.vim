" --- Configure Coc.nvim {{{
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
      \ 'nextKeymap': '<C-n>',
      \ 'previousKeymap': '<C-p>',
      \ 'insertMappings': {
      \   '<A-n>': 'prompt:next',
      \   '<A-p>': 'prompt:previous',
      \   '<C-g>': 'do:cancel',
      \   },
      \ 'normalMappings': {
      \   '<A-n>': 'prompt:next',
      \   '<A-p>': 'prompt:previous',
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
        \     'completion': {
        \       'filterAndSort': v:false
        \     },
        \   }
        \ }
endif

if executable('gopls')
  let s:languageservers['golang'] = {
        \   'command': 'gopls',
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

" --- Custom commands {{{
" Format: format current buffer
command! -nargs=0 Format :call CocAction('format')
" Fold: fold current buffer
command! -nargs=? Fold   :call CocAction('fold', <f-args>)
" Rg: grep (requires coc-lists extension)
command! -nargs=+ -complete=custom,s:GrepArgs Rg exe 'CocList grep '.<q-args>

function! s:GrepArgs(...)
  let list = ['-S', '-smartcase', '-i', '-ignorecase', '-w', '-word',
        \ '-e', '-regex', '-u', '-skip-vcs-ignores', '-t', '-extension']
  return join(list, "\n")
endfunction
" }}}
