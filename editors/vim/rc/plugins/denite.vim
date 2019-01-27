" Keymapping in denite buffer {{{
" --- Insert mode {{{
call denite#custom#map('insert', '<C-a>',
      \ '<denite:move_caret_to_head>', 'noremap')
call denite#custom#map('insert', '<C-b>',
      \ '<denite:move_caret_to_left>', 'noremap')
call denite#custom#map('insert', '<C-d>',
      \ '<denite:delete_char_under_caret>', 'noremap')
call denite#custom#map('insert', '<C-e>',
      \ '<denite:move_caret_to_tail>', 'noremap')
call denite#custom#map('insert', '<C-f>',
      \ '<denite:move_caret_to_right>', 'noremap')
call denite#custom#map('insert', '<BS>',
      \ '<denite:smart_delete_char_before_caret>', 'noremap')
call denite#custom#map('insert', '<C-h>',
      \ '<denite:smart_delete_char_before_caret>', 'noremap')
" <C-n>, <C-p> are mapped by default to recall command-line history.
" Use <M-n> and <M-p> for these operations.
call denite#custom#map('insert', '<C-n>',
      \ '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<C-p>',
      \ '<denite:move_to_previous_line>', 'noremap')
call denite#custom#map('insert', '<M-n>',
      \ '<denite:assign_next_text>', 'noremap')
call denite#custom#map('insert', '<M-p>',
      \ '<denite:assign_previous_text>', 'noremap')
call denite#custom#map('insert', '<C-r>',
      \ '<denite:toggle_matchers:matcher_substring>', 'noremap')
call denite#custom#map('insert', '<C-s>',
      \ '<denite:toggle_sorters:sorter_reverse>', 'noremap')
" <C-g> to quit denite
call denite#custom#map('insert', '<C-g>',
      \ '<denite:leave_mode>', 'noremap')
" jj to move to normal mode
call denite#custom#map('insert', 'jj',
      \ '<denite:enter_mode:normal>', 'noremap')
" }}}

" Normal mode {{{
call denite#custom#map('normal', '<C-n>',
      \ '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('normal', '<C-p>',
      \ '<denite:move_to_previous_line>', 'noremap')
call denite#custom#map('normal', '<C-g>',
      \ '<denite:leave_mode>', 'noremap')
call denite#custom#map('normal', 'r',
      \ '<denite:do_action:quickfix>', 'noremap')
" }}}
" }}}

" Find command {{{
if executable('fd')
  call denite#custom#var('file/rec', 'command',
        \ ['fd', '--type', 'file', '--follow', '--full-path', '--hidden',
        \  '--exclude', '.git'])
  call denite#custom#var('directory_rec', 'command',
        \ ['fd', '--type', 'directory', '--full-path', '--follow', '--hidden'])
elseif executable('rg')
  call denite#custom#var('file/rec', 'command',
        \ ['rg', '--files', '--hidden', '--glob', '!.git'])
elseif executable('ag')
  call denite#custom#var('file/rec', 'command',
        \ ['ag', '--follow', '--nocolor', '--nogroup', '--hidden', '-g', ''])
endif
" }}}

" Grep commmand {{{
if executable('rg')
  call denite#custom#var('grep', 'command', ['rg'])
  call denite#custom#var('grep', 'default_opts', ['--vimgrep', '--no-heading'])
  call denite#custom#var('grep', 'recursive_opts', [])
  call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
  call denite#custom#var('grep', 'separator', ['--'])
  call denite#custom#var('grep', 'final_opt', [])
elseif executable('ag')
  call denite#custom#var('grep', 'command', ['ag'])
  call denite#custom#var('grep', 'default_opts', ['-i', '--vimgrep'])
  call denite#custom#var('grep', 'recursive_opts', [])
  call denite#custom#var('grep', 'pattern_opt', [])
  call denite#custom#var('grep', 'separator', ['--'])
  call denite#custom#var('grep', 'final_opt', [])
elseif executable('ack')
  call denite#custom#var('grep', 'command', ['ack'])
  call denite#custom#var('grep', 'recursive_opts', [])
  call denite#custom#var('grep', 'pattern_opt', ['--match'])
  call denite#custom#var('grep', 'separator', ['--'])
  call denite#custom#var('grep', 'final_opts', [])
  call denite#custom#var('grep', 'default_opts',
        \ ['--ackrc', $HOME.'/.config/ackrc', '-H',
        \ '--nopager', '--nocolor', '--nogroup', '--column'])
endif
" }}}

" Matchers {{{
call denite#custom#source('file/rec', 'matchers', ['matcher/fruzzy'])
call denite#custom#source('file/old', 'matchers',
      \ ['matcher/fruzzy', 'matcher/project_files'])
call denite#custom#source('tag', 'matchers', ['matcher/substring'])
" }}}

" Sorters {{{
call denite#custom#source('file/rec', 'sorters', ['sorter_sublime'])
" }}}

" Converters {{{
call denite#custom#source('file/old', 'converters',
      \ ['converter/relative_word'])
" }}}

" Aliases {{{
call denite#custom#var('file/rec/git', 'command',
      \ ['git', 'ls-files', '-co', '--exclude-standard'])
call denite#custom#alias('source', 'file/rec/git', 'file/rec')
" }}}

" Change default prompt
call denite#custom#option('default', {
      \ 'auto_accel': v:true,
      \ 'prompt': '>',
      \ 'source_names': 'short',
      \ })

" Edit search results by Qfreplace {{{
if dein#tap('vim-qfreplace')
  function! DeniteQfreplace(context)
    let l:qflist = []
    for l:target in a:context['targets']
      if !has_key(l:target, 'action__path') | continue | endif
      if !has_key(l:target, 'action__line') | continue | endif
      if !has_key(l:target, 'action__text') | continue | endif

      call add(l:qflist, {
            \ 'filename': l:target['action__path'],
            \ 'lnum':     l:target['action__line'],
            \ 'text':     l:target['action__text']
            \ })
    endfor
    call setqflist(l:qflist)
    call qfreplace#start('')
  endfunction
  call denite#custom#action('file', 'qfreplace', function('DeniteQfreplace'))
  call denite#custom#map('normal', 'R',
        \ '<denite:do_action:qfreplace>', 'noremap')
endif
" }}}

" Appearance {{{
" Change highlight colors/style in insert mode.
call denite#custom#option('_', 'highlight_mode_insert', 'Search')

" Change ignore_globs
call denite#custom#filter('matcher/ignore_globs', 'ignore_globs',
      \ [ '.git/', '.ropeproject/', '__pycache__/',
      \   'venv/', '.venv/', 'images/', '*.min.*', 'img/', 'fonts/'])

" Display file icons in Denite* command: requires Vim-devicons
if dein#tap('vim-devicons')
  call denite#custom#source('file/rec,file/old,buffer,directory_rec',
        \ 'converters', ['devicons_denite_converter'])
endif
" }}}

"-----------------------------------------------------------------------------
" vim: foldmethod=marker
