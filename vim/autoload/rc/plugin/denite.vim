function! rc#plugin#denite#hook_add() abort
  " Substitute search commands by denite
  nnoremap <silent> / :<C-u>Denite -buffer-name=search -auto-highlight line<CR>
  nnoremap <silent> * :<C-u>DeniteCursorWord -buffer-name=search -auto-highlight -mode=normal line<CR>
  " Substitute 'n' command
  nnoremap <silent> n :<C-u>Denite -buffer-name=search -auto-highlight -resume -mode=normal -refresh<CR>


  " Press <Leader> twice to call a command or command history
  nnoremap <silent> <Space><Space> :<C-u>Denite command command_history<CR>

  " -- B mapping
  nnoremap <silent> <Space>bb :<C-u>Denite -mode=normal buffer<CR>
  nnoremap <silent> <Space>bf :<C-u>DeniteBufferDir -mode=insert file_rec<CR>
  nnoremap <silent> <Space>bF :<C-u>DeniteBufferDir -mode=normal file<CR>
  " Grep current buffer
  nnoremap <silent> <Space>bg :<C-u>DeniteBufferDir -buffer-name=search -no-empty -mode=normal grep<CR>
  xnoremap <silent> <Space>bg :<C-u>DeniteBufferDir grep:::`GetVisualSelectionESC()` -no-empty<CR>
  nnoremap <silent> <Space>bG :<C-u>DeniteBufferDir grep:::`expand('<cword>')` -no-empty<CR>

  " -- D mapping
  nnoremap <silent> <Space>dg :<C-u>Denite ghq<CR>
  nnoremap <silent> <Space>dh :<C-u>Denite help<CR>
  nnoremap <silent> <Space>dj :<C-u>Denite jump changed<CR>
  nnoremap <silent> <Space>do :<C-u>Denite outline<CR>
  nnoremap <silent> <Space>dp :<C-u>Denite -default-action=open dein<CR>
  nnoremap <silent> <Space>dr :<C-u>Denite -resume<CR>
  nnoremap <silent> <Space>ds :<C-u>Denite session -buffer-name=list<CR>
  nnoremap <silent> <Space>dt :<C-u>Denite tag<CR>

  " -- F mapping
  nnoremap <silent> <Space>ff :<C-u>Denite file_rec -path=`getcwd()`<CR>
  nnoremap <silent> <Space>fd :<C-u>Denite file_rec -path=`g:vimrc_root`<CR>
  nnoremap <silent> <Space>fr :<C-u>Denite file_mru<CR>
  nnoremap <silent> <Space>ft :<C-u>Denite filetype<CR>

  " -- P mapping
  nnoremap <silent> <Space>pf :<C-u>DeniteProjectDir file_rec<CR>
  nnoremap <silent> <Space>pF :<C-u>DeniteProjectDir file<CR>
  nnoremap <silent> <Space>pg :<C-u>DeniteProjectDir -buffer-name=search -no-empty -mode=normal grep<CR>
  xnoremap <silent> <Space>pg :<C-u>DeniteProjectDir -buffer-name=search -no-empty grep:::`GetVisualSelectionESC()`<CR>
  nnoremap <silent> <Space>pG :<C-u>DeniteProjectDir -buffer-name=search -no-empty grep:::`expand('<cword>')`<CR>

  " -- Y mapping
  nnoremap <silent> <Space>yy :<C-u>Denite -buffer-name=register register neoyank<CR>
  xnoremap <silent> <Space>yy :<C-u>Denite -default-action=replace -buffer-name=register register neoyank<CR>

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
    call denite#custom#map('normal', 'R', '<denite:do_action:qfrepalce>', 'noremap')
  endif

  " Display file icons in Denite* command: requires Vim-devicons
  if dein#tap('vim-devicons')
    call denite#custom#source('file_rec,file_old,buffer,directory_rec',
          \ 'converters', ['devicons_denite_converter'])
  endif
endfunction

