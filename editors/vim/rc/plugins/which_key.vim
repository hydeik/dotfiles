"] Leader mappings {{{
let g:which_key_leader_map = {}

let g:which_key_leader_map['b'] = 'buffer-list'

let g:which_key_leader_map.c = {
      \ 'name': '+coc',
      \ 'c': 'commands',
      \ 'd': 'diagnostics',
      \ 'e': 'extensions',
      \ 'j': 'jump-locations',
      \ 'l': 'lists',
      \ 'L': 'links',
      \ 'o': 'outline',
      \ 'O': 'output-channels',
      \ 's': 'workspace-symbols',
      \ 'S': 'sources',
      \ 'n': 'coc-next',
      \ 'p': 'coc-previous',
      \ 'r': 'coc-resume',
      \ }
let g:which_key_coc_map = {
      \ 'c': 'commands',
      \ 'd': 'diagnostics',
      \ 'e': 'extensions',
      \ 'j': 'next-item',
      \ 'k': 'previous-item',
      \ 'o': 'outline',
      \ 'r': 'resume-list',
      \ 's': 'workspace-symbols',
      \ 'S': 'completion-sources',
      \ ';': 'menu',
      \ 'b': 'buffer-list',
      \ 'f': 'open-file',
      \ 'g': 'grep',
      \ 'm': 'mru',
      \ 'y': 'yank',
      \ 'l': 'locationlist',
      \ 'q': 'quickfix',
      \ 'u': 'snippets',
      \ '/': 'words',
      \ }

let g:which_key_leader_map['e'] = 'file-explorer'

" let g:which_key_leader_map['f'] = 'files'
let g:which_key_leader_map.f = {
      \ 'name': '+file',
      \ 'f': 'file-list',
      \ 'r': 'mru-list',
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

let g:which_key_leader_map.h = {
      \ 'name': '+hunk',
      \ 'n': 'next-hunk',
      \ 'p': 'previous-hunk',
      \ 's': 'stage-hunk',
      \ 'u': 'undo-hunk',
      \ 'v': 'preview-hunk',
      \ }

let g:which_key_leader_map['J'] = 'join-with-chars'

let g:which_key_leader_map['s'] = 'snippet-list'

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

let g:which_key_leader_map['?'] = 'help'
let g:which_key_leader_map['*'] = 'grep-current-word'
let g:which_key_leader_map['/'] = 'grep'
let g:which_key_leader_map["'"] = 'open-terminal'
let g:which_key_leader_map[']'] = 'tag-jump'
let g:which_key_leader_map['['] = 'jump-location'

call which_key#register('<Space>', 'g:which_key_leader_map')
" }}}

" CocList mappings {{{
let g:which_key_coc_map = {
      \ 'c': 'commands',
      \ 'd': 'diagnostics',
      \ 'e': 'extensions',
      \ 'j': 'next-item',
      \ 'k': 'previous-item',
      \ 'o': 'outline',
      \ 'r': 'resume-list',
      \ 's': 'workspace-symbols',
      \ 'S': 'completion-sources',
      \ ';': 'menu',
      \ 'b': 'buffer-list',
      \ 'f': 'open-file',
      \ 'g': 'grep',
      \ 'm': 'mru',
      \ 'y': 'yank',
      \ 'l': 'locationlist',
      \ 'q': 'quickfix',
      \ 'u': 'snippets',
      \ '/': 'words',
      \ }

let g:which_key_coc_lsp_map = {
      \ 'ca': 'code-action',
      \ 'cl': 'code-lens',
      \ 'd': 'goto-definition',
      \ 'D': 'goto-declaration',
      \ 'h': 'document-hover',
      \ 'i': 'goto-implementation',
      \ 'I': 'diagnostic-info',
      \ 'f': 'formatting',
      \ 'F': 'fix-current',
      \ 'n': 'next-diagnostic',
      \ 'o': 'outline',
      \ 'p': 'previous-diagnostic',
      \ 'r': 'references',
      \ 'R': 'rename-symbol',
      \ 's': 'workspace-symbol',
      \ 't': 'goto-type-definition',
      \ }
" }}}

" lsp mappings {{{
let g:which_key_localleader_map = {}

let g:which_key_localleader_map = {
      \ 'a' : 'diagnostics',
      \ 'c': {
      \   'name': '+code',
      \   'a': 'code-action',
      \   'l': 'code-lens',
      \   },
      \ 'd': 'goto-definition',
      \ 'D': 'goto-declaration',
      \ 'h': 'document-hover',
      \ 'i': 'goto-implementation',
      \ 'I': 'diagnostic-info',
      \ 'f': 'formatting',
      \ 'F': 'fix-current',
      \ 'n': 'next-diagnostic',
      \ 'o': 'outline',
      \ 'p': 'previous-diagnostic',
      \ 'r': 'references',
      \ 'R': 'rename-symbol',
      \ 's': 'workspace-symbol',
      \ 't': 'goto-type-definition',
      \ }

" Register dictionary
call which_key#register(';', 'g:which_key_localleader_map')
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
      \ 'x':  'window-empty-buffer',
      \ 'z':  'window-toggle-zoom',
      \ }

" Register dictionary
call which_key#register('s', 'g:which_key_s_map')
" }}}

autocmd MyAutoCmd FileType which_key set laststatus=0
      \| autocmd MyAutoCmd BufLeave <buffer> set laststatus=2
