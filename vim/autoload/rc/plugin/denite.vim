function! rc#plugin#denite#hook_add() abort
  " Substitute search commands by denite
  nnoremap <silent> / :<C-u>Denite           -buffer-name=search -auto-highlight line<CR>
  nnoremap <silent> * :<C-u>DeniteCursorWord -buffer-name=search -auto-highlight -mode=normal line<CR>
  " Substitute 'n' command
  nnoremap <silent> n :<C-u>Denite           -buffer-name=search -auto-highlight -resume -mode=normal -refresh<CR>

  " command history
  nnoremap <silent> ;; :<C-u>Denite command command_history<CR>

  nnoremap <silent> ;h :<C-u>Denite help<CR>
  nnoremap <silent> ;b :<C-u>Denite buffer -mode=normal<CR>

  nnoremap <silent> ;r :<C-u>Denite -resume<CR>
  nnoremap <silent> ;y :<C-u>Denite -buffer-name=register register neoyank<CR>
  xnoremap <silent> ;y :<C-u>Denite -default-action=replace -buffer-name=register register neoyank<CR>

  nnoremap <silent> ;g :<C-u>Denite -buffer-name=search -no-empty -mode=normal grep<CR>

  nnoremap <silent> ;ff :<C-u>Denite file_rec<CR>
  nnoremap <silent> ;ft :<C-u>Denite filetype<CR>
  nnoremap <silent> ;fd :<C-u>Denite file_rec:~/.vim<CR>
endfunction

function! rc#plugin#denite#hook_source() abort
  " Keymapping for denite/insert mode
  call denite#custom#map('insert', '<C-a>', '<denite:move_caret_to_head>', 'noremap')
  call denite#custom#map('insert', '<C-b>', '<denite:move_caret_to_left>', 'noremap')
  call denite#custom#map('insert', '<C-d>', '<denite:delete_char_under_caret>', 'noremap')
  call denite#custom#map('insert', '<C-e>', '<denite:move_caret_to_tail>', 'noremap')
  call denite#custom#map('insert', '<C-f>', '<denite:move_caret_to_right>', 'noremap')
  call denite#custom#map('insert', '<C-h>', '<denite:delete_char_before_caret>', 'noremap')
  " Use <C-j>, <C-k> to move lines.
  call denite#custom#map('insert', '<C-j>', '<denite:move_to_next_line>', 'noremap')
  call denite#custom#map('insert', '<C-k>', '<denite:move_to_previous_line>', 'noremap')
  " <C-n>, <C-p> are mapped by default to recall command-line history.
  " call denite#custom#map('insert', '<C-n>', '<denite:assign_next_text>', 'noremap')
  " call denite#custom#map('insert', '<C-p>', '<denite:assign_previous_text>', 'noremap')
  call denite#custom#map('insert', '<C-r>', '<denite:toggle_matchers:matcher_substring>', 'noremap')
  call denite#custom#map('insert', '<C-s>', '<denite:toggle_sorters:sorter_reverse>', 'noremap')
  " <C-g> to quit denite
  call denite#custom#map('insert', '<C-g>', '<denite:leave_mode>', 'noremap')

  call denite#custom#map('normal', 'r', '<denite:do_action:quickfix>', 'noremap')

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
  call denite#custom#source('file_old', 'matchers', ['matcher_fuzzy', 'matcher_project_files'])
  call denite#custom#source('tag', 'matchers', ['matcher_substring'])
  if has('nvim')
    call denite#custom#source('file_rec', 'matchers', ['matcher_cpsm'])
  endif

  " Change sorters
  call denite#custom#source('file_rec', 'sorters', ['sorter_sublime'])

  " Change converters
  call denite#custom#source('file_old', 'converters', ['converter_relative_word'])

  " Define alias
  call denite#custom#alias('source', 'file_rec/git', 'file_rec')
  call denite#custom#var('file_rec/git', 'command',
    \ ['git', 'ls-files', '-co', '--exclude-standard'])

  " Change default prompt
  call denite#custom#option('default', {
        \ 'auto_accel': v:true,
        \ 'prompt': '>',
        \ 'source_names': 'short',
        \ })

  " Custom menu
  let s:menus = {}
  let s:menus.vim = {
    \ 'description': 'vim configuration',
    \ }
  let s:menus.vim.file_candidates = [
    \ ['    > Edit configuration file (init.vim)', '~/.config/nvim/init.vim']
    \ ]
  let s:menus.zsh = {
    \ 'description': 'zsh configuration'
    \ }
  let s:menus.zsh.file_candidates = [
    \ ['    > Edit zshenv', '~/.config/zsh/.zshenv'],
    \ ['    > Edit zshrc',  '~/.config/zsh/.zshrc'],
    \ ['    > Edit zplug configuration',  '~/.config/zsh/zplug.zsh']
    \ ]

  call denite#custom#var('menu', 'menus', s:menus)

  " Change ignore_globs
  call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
    \ [ '.git/', '.ropeproject/', '__pycache__/',
    \   'venv/', '.venv/', 'images/', '*.min.*', 'img/', 'fonts/'])
endfunction

