" Space mappings {{{
" -----
let g:which_key_space_map = {
      \ ' ':  ['CocList', 'available lists'],
      \ '[':  'previous item in list',
      \ ']':  'next item in list',
      \ ';':  'vim commands',
      \ ':':  'command history',
      \ '/':  'grep',
      \ '*':  'grep-from-selected',
      \ 'F':  'workspace folders',
      \ 'b':  'buffers',
      \ 'c':  'coc-commands',
      \ 'd':  'Defx',
      \ 'e':  'coc-extensions',
      \ 'f':  'files',
      \ 'g':  'git-status',
      \ 'h':  'help',
      \ 'k':  'key-mappings',
      \ 'l':  'locationlist',
      \ 'p':  'resume list',
      \ 'q':  'quickfix',
      \ 'r':  'mru',
      \ 's':  'snippets',
      \ 'v':  'Vista',
      \ 'y':  'yank list',
      \ }

" tig
let g:which_key_space_map.t = {
     \ 'name': '+tig',
     \ 'b': 'tig blame',
     \ 't': 'tig (current file)',
     \ 'p': 'tig (project)',
     \ 'r': 'tig grep resume',
     \ '/': 'tig grep',
     \ '*': 'tig grep <cword>',
     \ }

call which_key#register('<Space>', 'g:which_key_space_map')
" }}}

" 'm' mappings {{{
" -----
" Key mapping for LSP features
let g:which_key_m_map = {
      \ '?': 'diagnostic-info',
      \ '[': 'diagnostic-prev',
      \ ']': 'diagnostic-next',
      \ 'A': 'codeaction',
      \ 'D': 'declaration',
      \ 'F': 'fix-current',
      \ 'R': 'rename',
      \ 'a': 'codeaction-selected',
      \ 'd': 'definition',
      \ 'f': 'format',
      \ 'h': 'document-hover',
      \ 'i': 'implementation',
      \ 'j': 'list-location',
      \ 'L': 'codelens',
      \ 'o': 'document-symbols',
      \ 'q': 'list-diagnostics',
      \ 'r': 'reference',
      \ 's': 'workspace-symbols',
      \ 't': 'type-definition',
      \ }

call which_key#register('m', 'g:which_key_m_map')
" }}}

" leader mappings {{{
" -----
let g:which_key_leader_map = {
      \ 'J': 'join-with-chars',
      \ 'Q': 'quit-without-saving',
      \ 'W': 'save-all-buffers',
      \ 'a': 'easy-align',
      \ 'q': 'quit',
      \ 'w': 'save',
      \ 'x': 'strip-whitespace',
      \ ';': ':{command}',
      \ }

let g:which_key_leader_map.c = {
      \ 'name': '+comment',
      \ 'a': 'caw:dollarpos:toggle',
      \ 'b': 'caw:box:toggle',
      \ 'c': 'caw:hatpos:toggle',
      \ 'w': 'caw:wrap:toggle',
      \ '[': 'caw:jump:comment-prev',
      \ ']': 'caw:jump:comment-next',
      \ }

let g:which_key_leader_map.t = {
     \ 'name': '+toggle',
     \ 'c':  'cursor-columns',
     \ 'h':  'listchars',
     \ 'l':  'cursor-line',
     \ 'n':  'line-number',
     \ 'p':  'paste-mode',
     \ 'r':  'relative-number',
     \ 's':  'spell-check',
     \ 'w':  'wrap-text',
     \ }

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
