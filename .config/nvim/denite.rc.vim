" Change file_rec and grep commmand
if executable('rg')
  call denite#custom#var('file_rec', 'command', ['rg', '--files', '--glob', '!.git', ''])
  call denite#custom#var('grep', 'command', ['rg'])
  call denite#custom#var('grep', 'default_opts', ['--vimgrep', '--no-heading'])
  call denite#custom#var('grep', 'recursive_opts', [])
  call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
  call denite#custom#var('grep', 'separator', ['--'])
  call denite#custom#var('grep', 'final_opt', [])
elseif executable('pt')
  call denite#custom#var('file_rec', 'command', ['pt', '--follow', '--nocolor', '--nogroup',
                       \ (has('win32') ? '-g:' : '-g='), ''])
  call denite#custom#var('grep', 'command', ['pt'])
  call denite#custom#var('grep', 'default_opts', ['--nocolor', '--nogroup', '--smart-case'])
  call denite#custom#var('grep', 'recursive_opts', [])
  call denite#custom#var('grep', 'pattern_opt', [])
  call denite#custom#var('grep', 'separator', ['--'])
  call denite#custom#var('grep', 'final_opt', [])
else
  call denite#custom#var('file_rec', 'command', ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
  call denite#custom#var('grep', 'command', ['ag'])
  call denite#custom#var('grep', 'default_opts', ['-i', '--vimgrep'])
  call denite#custom#var('grep', 'recursive_opts', [])
  call denite#custom#var('grep', 'pattern_opt', [])
  call denite#custom#var('grep', 'separator', ['--'])
  call denite#custom#var('grep', 'final_opt', [])
endif

" Change matchers
call denite#custom#source('file_mru', 'matchers', ['matcher_fuzzy', 'matcher_project_files'])
call denite#custom#source('file_rec', 'matchers', ['matcher_cpsm'])

" Change sorters
call denite#custom#source('file_rec', 'sorters', ['sorter_sublime'])

" Change converters
call denite#custom#source('file_mru', 'converters', ['converter_relative_word'])

" Define alias
call denite#custom#alias('source', 'file_rec/git', 'file_rec')
call denite#custom#var('file_rec/git', 'command',
  \ ['git', 'ls-files', '-co', '--exclude-standard'])

" Change default prompt
call denite#custom#option('default', 'prompt', '>')

" Change ignore_globs
call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
  \ [ '.git/', '.ropeproject/', '__pycache__/',
  \   'venv/', 'images/', '*.min.*', 'img/', 'fonts/'])

" Keymapping
call denite#custom#map('insert', '<C-a>', '<denite:move_caret_to_head>', 'noremap')
call denite#custom#map('insert', '<C-j>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<C-k>', '<denite:move_to_previous_line>', 'noremap')
call denite#custom#map('insert', '<C-t>', '<denite:do_action:tabopen>', 'noremap')
call denite#custom#map('insert', '<C-d>', '<denite:do_action:delete>', 'noremap')
call denite#custom#map('insert', '<C-b>', '<denite:scroll_page_backward>', 'noremap')
call denite#custom#map('insert', '<C-f>', '<denite:scroll_page_forward>', 'noremap')
call denite#custom#map('insert', '<C-p>', '<denite:scroll_page_forward>', 'noremap')

call denite#custom#map('normal', '<Esc>', '<denite:quit>', 'noremap')
