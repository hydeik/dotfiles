" Leader mappings {{{
let g:which_key_leader_map = {}

let g:which_key_leader_map['b'] = 'buffer-list'

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

let g:which_key_leader_map['e'] = 'file-explorer'

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

let g:which_key_leader_map['p'] = 'quick-open'
let g:which_key_leader_map['q'] = 'quit'
let g:which_key_leader_map['Q'] = 'quit-without-saving'
let g:which_key_leader_map['w'] = 'save'
let g:which_key_leader_map['W'] = 'save-all-buffers'

let g:which_key_leader_map.x = {
      \ 'name': '+text',
      \ 'a': 'easy-align',
      \ 'd': 'delete-trailing-whitespace',
      \ }

let g:which_key_leader_map['y'] = 'yank-list'

let g:which_key_leader_map['*'] = 'grep-current-word'
let g:which_key_leader_map['/'] = 'grep'
let g:which_key_leader_map["'"] = 'open-terminal'
let g:which_key_leader_map[']'] = 'denite-tag'
let g:which_key_leader_map['['] = 'denite-jump'

" let g:which_key_leader_map.w = {
"      \ 'name': '+windows',
"      \ 'w': 'other-window',
"      \ 'd': 'delete-window',
"      \ 'o': 'only-current-window',
"      \ 'h': 'window-left',
"      \ 'j': 'window-below',
"      \ 'k': 'window-up',
"      \ 'l': 'window-right',
"      \ 'H': 'expand-window-left',
"      \ 'J': 'expand-window-below',
"      \ 'K': 'expand-window-up',
"      \ 'L': 'expand-window-right',
"      \ '=': 'balance-window',
"      \ '-': 'split-window-below',
"      \ '|': 'split-window-right',
"      \ 's': 'split-window-below',
"      \ 'v': 'split-window-right',
"      \ }

call which_key#register('<Space>', 'g:which_key_leader_map')
" }}}

" s mappings {{{

let g:which_key_s_map = {}

" windows
let g:which_key_s_map['-'] = 'window-split-below'
let g:which_key_s_map['|'] = 'window-split-right'
let g:which_key_s_map['='] = 'window-balance'
let g:which_key_s_map['c'] = 'window-close'
let g:which_key_s_map['o'] = 'windown-only'
let g:which_key_s_map['t'] = 'window-tabnew'
let g:which_key_s_map['x'] = 'window-empty-buffer'
let g:which_key_s_map['z'] = 'window-toggle-zoom'

" EasyMotion
let g:which_key_s_map['f'] = 'easymotion-overwin-{char}'
let g:which_key_s_map['s'] = 'easymotion-overwin-{char}{char}'
let g:which_key_s_map['h'] = 'easymotion-linebackward'
let g:which_key_s_map['j'] = 'easymotion-j'
let g:which_key_s_map['k'] = 'easymotion-k'
let g:which_key_s_map['l'] = 'easymotion-lineforward'
let g:which_key_s_map['n'] = 'easymotion-move-next'
let g:which_key_s_map['p'] = 'easymotion-move-prev'
let g:which_key_s_map['/'] = 'easymotion-search'

" vim-sandwich
let g:which_key_s_map['a']  = 'sandwich-add'
let g:which_key_s_map['d']  = 'sandwich-delete'
let g:which_key_s_map['db'] = 'sandwich-delete-between'
let g:which_key_s_map['r']  = 'sandwich-replace'
let g:which_key_s_map['rb'] = 'sandwich-replace-between'

" Register dictionary
call which_key#register('s', 'g:which_key_s_map')
" }}}

autocmd MyAutoCmd FileType which_key set laststatus=0
      \| autocmd MyAutoCmd BufLeave <buffer> set laststatus=2
