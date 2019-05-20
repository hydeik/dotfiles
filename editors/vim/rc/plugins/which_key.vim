" Space mappings {{{
" -----
let g:which_key_space_map = {
      \ 'a':  'CocList diagnostics',
      \ 'b':  'CocList buffers',
      \ 'c':  'CocList commands',
      \ 'd':  'Defx',
      \ 'e':  'CocList extensions',
      \ 'g':  'CocList gstatus',
      \ 'h':  'CocList helptags',
      \ 'f':  'CocList files',
      \ 'm':  'CocList mru',
      \ 'l':  'CocList locationlist',
      \ 'o':  'CocList outline',
      \ 'q':  'CocList quickfix',
      \ 's':  'CocList symbols',
      \ 'u':  'CocList snippets',
      \ 'y':  'CocList yank',
      \ '/':  'CocList grep',
      \ '*':  'CocList grep <cword>',
      \ ' ':  'CocList',
      \ 'r':  'CocListResume',
      \ '[':  'CocPrev',
      \ ']':  'CocNext',
      \ }

" " Git
" let g:which_key_space_map.g = {
"     \ 'name': '+git',
"     \ 'b': 'branch',
"     \ 'c': 'commit-current-file',
"     \ 'C': 'commit-project',
"     \ 'f': 'ls-files',
"     \ 's': 'status',
"     \ }

let g:which_key_space_map.t = {
     \ 'name': '+toggle',
     \ 'c': {
     \   'name': '+cursor',
     \   'c': 'cursor-column',
     \   'l': 'cursor-line',
     \ },
     \ 'n':  'line-number',
     \ 'l':  'listchars',
     \ 'p':  'paste-mode',
     \ 'r':  'relative-number',
     \ 's':  'spell-check',
     \ 'w':  'wrap-text',
     \ }

call which_key#register('<Space>', 'g:which_key_space_map')
" }}}

" leader mappings {{{
" -----
let g:which_key_leader_map = {}

let g:which_key_leader_map['g'] = 'grep-from-selected-{motion}'
let g:which_key_leader_map['J'] = 'join-with-chars'
let g:which_key_leader_map['q'] = 'quit'
let g:which_key_leader_map['Q'] = 'quit-without-saving'

" let g:which_key_leader_map.S = {
"      \ 'name': '+session',
"      \ 'a': 'last-session',
"      \ 'l': 'list-session',
"      \ 'o': 'open-session',
"      \ 'r': 'remove-session',
"      \ 's': 'save-session',
"      \ }
"
let g:which_key_leader_map['w'] = 'save'
let g:which_key_leader_map['W'] = 'save-all-buffers'

let g:which_key_leader_map.x = {
     \ 'name': '+text',
     \ 'a': 'easy-align',
     \ 'd': 'delete-trailing-whiteleader',
     \ }

let g:which_key_leader_map[';'] = ':{command}'
let g:which_key_leader_map['/'] = 'grep'
let g:which_key_leader_map['*'] = 'grep <cword>'

" Register dictionary
call which_key#register(';', 'g:which_key_leader_map')
" }}}

" s mappings {{{
" ----
" Window manipulation, EasyMotion, Sandwich
let g:which_key_s_map = {
      \ 'f':  'easymotion-overwin-{char}',
      \ 's':  'easymotion-overwin-{char}{char}',
      \ 'h':  'easymotion-linebackward',
      \ 'j':  'easymotion-j',
      \ 'k':  'easymotion-k',
      \ 'l':  'easymotion-lineforward',
      \ 'n':  'easymotion-move-next',
      \ 'p':  'easymotion-move-prev',
      \ '/':  'easymotion-search',
      \ 'a':  'sandwich-add',
      \ 'd':  'sandwich-delete',
      \ 'db': 'sandwich-delete-between',
      \ 'r':  'sandwich-replace',
      \ 'rb': 'sandwich-replace-between',
      \ '-':  'window-split-below',
      \ '|':  'window-split-right',
      \ '=':  'window-balance',
      \ 'c':  'window-close',
      \ 'o':  'windown-only',
      \ 't':  'window-tabnew',
      \ 'x':  'window-clear-buffer',
      \ 'z':  'window-toggle-zoom',
      \ }

" Register dictionary
call which_key#register('s', 'g:which_key_s_map')
" }}}

" which-key buffer configuration
autocmd MyAutoCmd FileType which_key set laststatus=0
      \| autocmd MyAutoCmd BufLeave <buffer> set laststatus=2
