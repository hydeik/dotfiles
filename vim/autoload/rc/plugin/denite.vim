function! rc#plugin#denite#hook_add() abort
  " Substitute search commands by denite
  nnoremap <silent> / :<C-u>Denite line -buffer-name=search -auto-highlight<CR>
  nnoremap <silent> * :<C-u>DeniteCursorWord line -buffer-name=search -auto-highlight -mode=normal<CR>
  " Substitute 'n' command
  nnoremap <silent> n :<C-u>Denite -resume -buffer-name=search -auto-highlight -mode=normal -refresh<CR>
  " nnoremap <silent> n :<C-u>Denite -resume -buffer-name=search -select=+1 -immediately<CR>
  " nnoremap <silent> N :<C-u>Denite -resume -buffer-name=search -select=-1 -immediately<CR>

  nnoremap <silent> <LocalLeader>b  :<C-u>Denite buffer file/old -default-action=switch -mode=normal<CR>
  nnoremap <silent> <LocalLeader>d  :<C-u>Denite directory_rec -default-action=cd<CR>
  nnoremap <silent> <LocalLeader>f  :<C-u>Denite file_rec<CR>
  nnoremap <silent> <LocalLeader>g  :<C-u>Denite grep -buffer-name=search -no-empty<CR>
  nnoremap <silent> <LocalLeader>h  :<C-u>Denite help<CR>
  nnoremap <silent> <LocalLeader>n  :<C-u>Denite dein -default-action=open<CR>
  nnoremap <silent> <LocalLeader>j  :<C-u>Denite jump change file_point<CR>
  nnoremap <silent> <LocalLeader>o  :<C-u>Denite outline<CR>
  nnoremap <silent> <LocalLeader>;  :<C-u>Denite command command_history<CR>

  " Tag jump
  nnoremap <silent><expr> <LocalLeader>t &filetype == 'help' ? "g\<C-]>" :
        \ ":\<C-u>DeniteCursorWord -buffer-name=tag tag:include\<CR>"
  nnoremap <silent><expr> <LocalLeader>p  &filetype == 'help' ?
        \ ":\<C-u>pop\<CR>" : ":\<C-u>Denite -mode=normal jump\<CR>"

  " register / neoyank
  nnoremap <silent> <LocalLeade>r  :<C-u>Denite register neoyank -buffer-name=register<CR>
  xnoremap <silent> <LocalLeade>r  :<C-u>Denite register neoyank -buffer-name=register -default-action=replace<CR>

  " Quickfix and location list
  if dein#tap('unite-location')
    nnoremap L  <Nop>
    nnoremap Q  <Nop>
    nnoremap <silent>L  :<C-u>Denite location_list -buffer-name=list<CR>
    nnoremap <silent>Q  :<C-u>Denite quickfix -buffer-name=list<CR>
  endif

  " Manage Session
  if dein#tap('vim-denite-session')
    nnoremap <silent> <LocalLeader>s  :<C-u>Denite session -buffer-name=list<CR>
  endif

  " Repositories managed by 'ghq'
  if dein#tap('denite-ghq')
    nnoremap <silent> <LocalLeader>q  :<C-u>Denite ghq<CR>
  endif
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
  " jj to move to normal mode
  call denite#custom#map('insert', 'jj', '<denite:enter_mode:normal>', 'noremap')

  call denite#custom#map('normal', 'r', '<denite:do_action:quickfix>', 'noremap')

  " Change file_rec and grep commmand
  if executable('rg')
    call denite#custom#var('file_rec', 'command', ['rg', '--files', '--glob', '!.git'])
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
  call denite#custom#source('file/old', 'matchers', ['matcher_fuzzy', 'matcher_project_files'])
  call denite#custom#source('tag', 'matchers', ['matcher_substring'])
  if has('nvim')
    call denite#custom#source('file/rec', 'matchers', ['matcher_cpsm'])
  endif

  " Change sorters
  call denite#custom#source('file/rec', 'sorters', ['sorter_sublime'])

  " Change converters
  call denite#custom#source('file_old', 'converters', ['converter_relative_word'])

  " Define alias
  call denite#custom#alias('source', 'file/rec/git', 'file/rec')
  call denite#custom#var('file/rec/git', 'command',
        \ ['git', 'ls-files', '-co', '--exclude-standard'])

  " Change default prompt
  call denite#custom#option('default', {
        \ 'auto_accel': v:true,
        \ 'prompt': '>',
        \ 'source_names': 'short',
        \ })

  " Change highlight colors/style in insert mode.
  call denite#custom#option('_', 'highlight_mode_insert', 'Search')

  " Change ignore_globs
  call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
        \ [ '.git/', '.ropeproject/', '__pycache__/',
        \   'venv/', '.venv/', 'images/', '*.min.*', 'img/', 'fonts/'])

  " Edit search results by Qfreplace
  if dein#tap('vim-qfreplace')
    function! DeniteQfreplace(context)
      let l:qflist = []
      for l:target in a:context['targets']
        if !has_key(l:target, 'action__path') | continue | endif
        if !has_key(l:target, 'action__line') | continue | endif
        if !has_key(l:target, 'action__text') | continue | endif

        call add(qflist, {
              \ 'filename': l:target['action__path'],
              \ 'lnum':     l:target['action__line'],
              \ 'text':     l:target['action__text']
              \ })
      endfor
      call setqflist(l:qflist)
      call qfreplace#start('')
    endfunction
    call denite#custom#action('file', 'qfreplace', function('DeniteQfreplace'))
    call denite#custom#map('normal', 'R', '<denite:do_action:qfreplace>', 'noremap')
  endif

  " Display file icons in Denite* command: requires Vim-devicons
  if dein#tap('vim-devicons')
    call denite#custom#source('file/rec,file/old,buffer,directory_rec',
          \ 'converters', ['devicons_denite_converter'])
  endif
endfunction

