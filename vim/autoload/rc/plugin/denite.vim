function! rc#plugin#denite#hook_add() abort
  " Substitute search commands by denite
  nnoremap <silent> / :<C-u>Denite line -buffer-name=search -auto-highlight<CR>
  nnoremap <silent> * :<C-u>DeniteCursorWord line -buffer-name=search -auto-highlight -mode=normal<CR>
  " Substitute 'n' command
  nnoremap <silent> n :<C-u>Denite -resume -buffer-name=search -auto-highlight -mode=normal -refresh<CR>

  " Press <Leader> twice to call a command or command history
  nnoremap <silent> <Leader><Leader> :<C-u>Denite command command_history<CR>

  " -- B mapping
  nnoremap <silent> <Leader>bb :<C-u>Denite buffer -mode=normal<CR>
  nnoremap <silent> <Leader>bf :<C-u>DeniteBufferDir file_rec -mode=insert<CR>
  nnoremap <silent> <Leader>bF :<C-u>DeniteBufferDir file -mode=normal<CR>

  " Grep current buffer
  nnoremap <silent> <Leader>bg :<C-u>DeniteBufferDir grep -buffer-name=search -no-empty -mode=normal<CR>
  xnoremap <silent> <Leader>bg :<C-u>DeniteBufferDir grep:::`GetVisualSelectionESC()` -no-empty<CR>
  nnoremap <silent> <Leader>bG :<C-u>DeniteBufferDir grep:::`expand('<cword>')` -no-empty<CR>

  " -- D mapping
  nnoremap <silent> <Leader>dg :<C-u>Denite ghq<CR>
  nnoremap <silent> <Leader>dh :<C-u>Denite help<CR>
  nnoremap <silent> <Leader>dj :<C-u>Denite jump change<CR>
  nnoremap <silent> <Leader>do :<C-u>Denite outline<CR>
  nnoremap <silent> <Leader>dp :<C-u>Denite dein -default-action=open<CR>
  nnoremap <silent> <Leader>dr :<C-u>Denite -resume<CR>
  nnoremap <silent> <Leader>dt :<C-u>Denite tag<CR>

  " -- F mapping
  nnoremap <silent> <Leader>ff :<C-u>Denite file_rec -path=`getcwd()`<CR>
  nnoremap <silent> <Leader>fF :<C-u>Denite file -path=`getcwd()`<CR>
  nnoremap <silent> <Leader>fd :<C-u>Denite file_rec -path=`g:vimrc_root`<CR>
  nnoremap <silent> <Leader>fr :<C-u>Denite file_mru<CR>
  nnoremap <silent> <Leader>fs :<C-u>call save_file(0)<CR>
  nnoremap <silent> <Leader>fS :<C-u>call save_file(1)<CR>
  nnoremap <silent> <Leader>ft :<C-u>Denite filetype<CR>

  " -- H mapping
  nnoremap <silent> <Leader>hh :<C-u>Denite help<CR>

  " -- J mapping
  nnoremap <silent> <Leader>jl :<C-u>Denite jump change<CR>

  " -- P mapping
  nnoremap <silent> <Leader>pf :<C-u>DeniteProjectDir file_rec<CR>
  nnoremap <silent> <Leader>pF :<C-u>DeniteProjectDir file<CR>
  nnoremap <silent> <Leader>pg :<C-u>DeniteProjectDir grep -buffer-name=search -no-empty -mode=normal<CR>
  xnoremap <silent> <Leader>pg :<C-u>DeniteProjectDir grep:::`GetVisualSelectionESC()` -buffer-name=search -no-empty<CR>
  nnoremap <silent> <Leader>pG :<C-u>DeniteProjectDir grep:::`expand('<cword>')` -buffer-name=search -no-empty<CR>

  " -- Y mapping
  nnoremap <silent> <Leader>yy :<C-u>Denite register neoyank -buffer-name=register<CR>
  xnoremap <silent> <Leader>yy :<C-u>Denite register neoyank -buffer-name=register -default-action=replace<CR>

  function! s:GetVisualSelection() abort "{{{
    return getline("'<")[getpos("'<")[1:2][1] - 1: getpos("'>")[1:2][1] - 1]
  endfunction "}}}

  " Save function
  function! s:save_file(force)
    let l:cmd = &readonly ? 'SudoWrite' : a:force ? 'w!' : 'w'
    execute l:cmd
  endfunction
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
    call denite#custom#map('normal', 'R', '<denite:do_action:qfreplace>', 'noremap')
  endif

  " Display file icons in Denite* command: requires Vim-devicons
  if dein#tap('vim-devicons')
    call denite#custom#source('file_rec,file_old,buffer,directory_rec',
          \ 'converters', ['devicons_denite_converter'])
  endif
endfunction

