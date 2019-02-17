let g:which_key_leader_map = {}

let g:which_key_leader_map['*'] = 'grep-current-word'
let g:which_key_leader_map['/'] = 'grep'

let g:which_key_leader_map.b = {
      \ 'name': '+buffer',
      \ 'd': 'delete-buffer',
      \ 'D': 'delete-buffer-force',
      \ 'f': 'first-buffer',
      \ 'l': 'last-buffer',
      \ 'n': 'next-buffer',
      \ 'p': 'previous-buffer',
      \ 'b': 'Denite-buffer',
      \ '?': 'Denite-buffer',
      \ }

let g:which_key_leader_map.c = {
      \ 'name': '+coc',
      \ 'c': 'commands',
      \ 'd': 'diagnostics',
      \ 'e': 'extensions',
      \ 'j': 'jump-locations',
      \ 'l': 'links',
      \ 'o': 'outline',
      \ 'O': 'output-channels',
      \ 's': 'symbols',
      \ 'S': 'sources',
      \ 'n': 'coc-next',
      \ 'p': 'coc-previous',
      \ 'r': 'coc-resume',
      \ }

let g:which_key_leader_map.e = {
      \ 'name': '+error',
      \ 'n': 'next-error',
      \ 'p': 'previous-error',
      \ }

let g:which_key_leader_map.f = {
      \ 'name': '+file',
      \ 'f': 'Denite-file',
      \ 'r': 'recent-file',
      \ 's': 'save-file',
      \ 'S': 'save-all-files',
      \ 't': 'Denite-filetype',
      \ }

let g:which_key_leader_map.g = {
      \ 'name': '+git',
      \ 'b': 'gina-branch',
      \ 'c': 'gina-commit',
      \ 'C': 'gina-commit-amend',
      \ 'A': 'gina-changes-origin',
      \ 'd': 'gina-changes-origin',
      \ 'l': 'gina-log',
      \ 'f': 'gina-ls',
      \ 's': 'gina-status',
      \ 't': 'gina-tag',
      \ }

let g:which_key_leader_map['h'] = 'help'
let g:which_key_leader_map['J'] = 'join-with-chars'

" let g:which_key_leader_map.l = {
"      \ 'name': '+lsp',
"      \ 'c': {
"      \   'name': '+code',
"      \   'a': 'code-action',
"      \   'l': 'code-lens',
"      \   },
"      \ 'd': 'diagnostic-info',
"      \ 'h': 'hover',
"      \ 'f': 'formatting',
"      \ 'F': 'fix-current',
"      \ 'o': 'outline',
"      \ 'r': 'reference',
"      \ 'R': 'rename',
"      \ 's': 'workspace-symbol',
"      \ 'g': {
"      \   'name': '+goto',
"      \   'd': 'definition',
"      \   't': 'type-definition',
"      \   'i': 'implementation',
"      \   },
"      \ }

let g:which_key_leader_map.S = {
      \ 'name': '+session',
      \ 'a': 'last-session',
      \ 'l': 'list-session',
      \ 'o': 'open-session',
      \ 'r': 'remove-session',
      \ 's': 'save-session',
      \ }

let g:which_key_leader_map.t = {
      \ 'name': '+toggle',
      \ 'n': 'line-number',
      \ 'c': 'cursor-column',
      \ 'l': 'listchars',
      \ 'p': 'paste-mode',
      \ 's': 'spell-check',
      \ 'w': 'wrap-text',
      \ }

let g:which_key_leader_map.w = {
      \ 'name': '+windows',
      \ 'w': 'other-window',
      \ 'd': 'delete-window',
      \ 'o': 'only-current-window',
      \ 'h': 'window-left',
      \ 'j': 'window-below',
      \ 'k': 'window-up',
      \ 'l': 'window-right',
      \ 'H': 'expand-window-left',
      \ 'J': 'expand-window-below',
      \ 'K': 'expand-window-up',
      \ 'L': 'expand-window-right',
      \ '=': 'balance-window',
      \ '-': 'split-window-below',
      \ '|': 'split-window-right',
      \ 's': 'split-window-below',
      \ 'v': 'split-window-right',
      \ }

let g:which_key_leader_map['q'] = 'quit'
let g:which_key_leader_map['Q'] = 'quit-without-saving'

let g:which_key_leader_map.x = {
      \ 'name': '+text',
      \ 'a': 'easy-align',
      \ 'd': 'delete-trailing-whitespace',
      \ }

let g:which_key_leader_map['y'] = 'yank-list'

call which_key#register('<Space>', 'g:which_key_leader_map')
autocmd MyAutoCmd FileType which_key set laststatus=0
      \| autocmd MyAutoCmd BufLeave <buffer> set laststatus=2
