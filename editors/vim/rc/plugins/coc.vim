"==============================
" Configuration of coc.nvim
"==============================

" --- Suggest / completion {{{
call coc#config('suggest', {
      \ 'autoTrigger': 'always',
      \ 'triggerAfterInsertEnter': v:true,
      \ 'timeout': 1000,
      \ 'noselect': v:true,
      \ 'formatOnType': v:false,
      \ 'snippetIndicator': "\uf0d0",
      \ 'enablePreview': v:true,
      \ 'completionItemKindLabels' : {
      \   'function': "\uf794",
      \   'method': "\uf6a6",
      \   'variable': "\uf71b",
      \   'constant': "\uf8ff",
      \   'struct': "\ufb44",
      \   'class': "\uf0e8",
      \   'interface': "\ufa52",
      \   'text': "\ue612",
      \   'enum': "\uf435",
      \   'enumMember': "\uf02b",
      \   'module': "\uf668",
      \   'color': "\ue22b",
      \   'property': "\ufab6",
      \   'field': "\uf93d",
      \   'unit': "\uf475",
      \   'file': "\uf471",
      \   'value': "\uf8a3",
      \   'event': "\ufacd",
      \   'folder': "\uf115",
      \   'keyword': "\uf893",
      \   'snippet': "\uf64d",
      \   'operator': "\uf915",
      \   'reference': "\uf87a",
      \   'typeParameter': "\uf278",
      \   'default': "\uf29c"
      \ },
      \ })
" }}}

" --- Diagnostics {{{
call coc#config('diagnostic', {
      \ 'enable': v:true,
      \ 'signOffset': 1000,
      \ 'errorSign': "\uf00d",
      \ 'warningSign': "\uf071",
      \ 'infoSign': "\uf05a",
      \ 'hintSign': "\uf27b",
      \ 'maxWindowHeight': 15
      \ })
" }}}

" --- Signature {{{
call coc#config('signature', {
      \ 'enable': v:true,
      \ 'maxWindowHeight': 15
      \ })
" }}}

" --- CocList {{{
call coc#config('list', {
      \ 'maxHeight': 15,
      \ 'maxPreviewHeight': 20,
      \ 'insertMappings': {
      \   '<C-g>': 'do:exit',
      \   },
      \ 'normalMappings': {
      \   '<C-g>': 'do:exit',
      \   'd':     'action:delete',
      \   },
      \ })
" }}}

" --- Language servers {{{
let s:languageservers = {}

" Python -> use coc-python
" Ruby   -> use coc-solargraph
" Rust   -> use coc-rls

" C/C++/Obj-C/Obj-C++
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

if executable('clangd')
  let s:languageservers['clangd'] = {
        \   'command': 'clangd',
        \   'filetypes': ['c', 'cpp', 'objc', 'objcpp'],
        \   'rootPatterns': ['compile_flags.txt', 'compile_commands.json',
        \                    '.vim', '.git', '.hg'],
        \   }
        \ }
endif

" Fortran
if executable('fortls')
  let s:languageservers['fortran'] = {
        \   'command': 'fortls',
        \   'filetypes': ['fortran']
        \ }
endif

" Go language
if executable('gopls')
  let s:languageservers['golang'] = {
        \   'command': 'gopls',
        \   'filetypes': ['go'],
        \   'rootPatterns': ['go.mod', '.vim', '.git', '.hg'],
        \ }
endif

" Docker
if executable('docker-langserver')
  let s:languageservers['dockerfile'] = {
        \   'command': 'docker-langserver',
        \   'args': ['--stdio'],
        \   'filetypes': ['dockerfile'],
        \ }
endif

" Reason
if executable('reason-language-server')
  let s:languageservers['reason'] = {
        \   'command': 'reason-language-server',
        \   'filetypes': ['reason']
        \ }
endif

" Bash
if executable('bash-language-server')
  let s:languageservers['bash'] = {
        \   'command': 'bash-language-server',
        \   'args': ['start'],
        \   'filetypes': ['sh'],
        \   'ignoredRootPaths': ['~']
        \ }
endif

" Vim/erb/Markdown
if executable('efm-langserver')
  let s:languageservers['efm'] = {
        \   'command': 'efm-langserver',
        \   'args': [],
        \   'filetypes': ['vim', 'eruby', 'markdown'],
        \   'ignoredRootPaths': ['~']
        \ }
endif

" Register language server configurations
if !empty(s:languageservers)
  call coc#config('languageserver', s:languageservers)
endif
" }}}

" --- Extensions {{{
call coc#config('git', {
      \ 'chagendSign':       { 'text': '~', 'hlGroup': 'AquaSign'   },
      \ 'addedSign':         { 'text': '+', 'hlGroup': 'GreenSign'  },
      \ 'removeSign':        { 'text': '_', 'hlGroup': 'RedSign'    },
      \ 'topRemovedSign':    { 'text': '‾', 'hlGroup': 'RedSign'    },
      \ 'changeRemovedSign': { 'text': '=', 'hlGroup': 'PurpleSign' },
      \ })

call coc#config('python', {
     \ 'formatting': {
     \   'blackPath': $PYENV_ROOT.'/versions/neovim3/bin/black',
     \   'provider': 'black',
     \ },
     \ 'linting': {
     \   'mypyPath': $PYENV_ROOT.'/versions/neovim3/bin/mypy',
     \   'pylintPath': $PYENV_ROOT.'/versions/neovim3/bin/pylint',
     \ },
     \ 'sortImports': {
     \   'path': $PYENV_ROOT.'/versions/neovim3/bin/isort',
     \ },
     \ 'venvPath': $PYENV_ROOT.'/versions',
     \ })

" }}}

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
