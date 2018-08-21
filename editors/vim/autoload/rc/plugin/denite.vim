function! s:get_selection(cmdtype) abort
  let l:temp = @s
  normal! gv"sy
  let @/ = substitute(escape(@s, '\'.a:cmdtype), '\n', '\\n', 'g')
  let @s = l:temp
endfunction

function! rc#plugin#denite#hook_add() abort
  " --- Key mappings

  " Substitute search commands by Denite line
  nnoremap <silent> / :<C-u>Denite line -buffer-name=search -auto-highlight<CR>
  nnoremap <silent> * :<C-u>DeniteCursorWord line -buffer-name=search -auto-highlight -mode=normal<CR>
  " Substitute 'n' command
  nnoremap <silent> n :<C-u>Denite -resume -buffer-name=search -auto-highlight -mode=normal -refresh<CR>
  " nnoremap <silent> n :<C-u>Denite -resume -buffer-name=search -select=+1 -immediately<CR>
  " nnoremap <silent> N :<C-u>Denite -resume -buffer-name=search -select=-1 -immediately<CR>

  " buffer/file/directory navigation
  nnoremap <silent> <Leader>b  :<C-u>Denite buffer file/old -default-action=switch -mode=normal<CR>
  nnoremap <silent> <Leader>d  :<C-u>Denite directory_rec -default-action=cd<CR>
  nnoremap <silent> <Leader>f  :<C-u>Denite file/rec<CR>
  nnoremap <silent> <Leader>F  :<C-u>Denite file<CR>
  nnoremap <silent> <Leader>j  :<C-u>Denite jump change file/point<CR>
  nnoremap <silent> <Leader>o  :<C-u>Denite outline<CR>

  " Resume the previous Denite buffer
  nnoremap <silent> <Leader>r  :<C-u>Denite -resume<CR>

  " Help (fuzzy-find)
  nnoremap <silent> <Leader>?  :<C-u>Denite help<CR>

  " Vim command/command_history (fuzzy-find)
  nnoremap <silent> <Leader><Leader>  :<C-u>Denite command command_history<CR>

  " Open Denite with word under cursor or selection
  nnoremap <silent> <Leader>gf :DeniteCursorWord file_rec<CR>

  " Grep
  nnoremap <silent> <Leader>gg  :<C-u>Denite grep -no-empty -buffer-name=search -mode=normal<CR>
  nnoremap <silent> <Leader>g*  :<C-u>DeniteCursorWord grep -no-empty -buffer-name=search -mode=normal<CR>
	vnoremap <silent> <Leader>g*  :<C-u>call <SID>get_selection('/')<CR>
        \ :execute 'Denite grep:::'.@/.' -no-empty -buffer-name=search -mode=normal'<CR><CR>


  " " Tag jump
  " nnoremap <silent><expr> <Leader>t &filetype == 'help' ? "g\<C-]>" :
  "       \ ":\<C-u>DeniteCursorWord -buffer-name=tag tag:include\<CR>"
  " nnoremap <silent><expr> <Leader>p  &filetype == 'help' ?
  "       \ ":\<C-u>pop\<CR>" : ":\<C-u>Denite -mode=normal jump\<CR>"
  "
  " register / neoyank
  nnoremap <silent> <Leader>y  :<C-u>Denite register neoyank -buffer-name=register<CR>
  xnoremap <silent> <Leader>y  :<C-u>Denite register neoyank -buffer-name=register -default-action=replace<CR>

  " Quickfix and location list
  nnoremap <silent>L  :<C-u>Denite location_list -buffer-name=list<CR>
  nnoremap <silent>Q  :<C-u>Denite quickfix -buffer-name=list<CR>

  " Plugins managed by 'Dein'
  nnoremap <silent> <Leader>Dn  :<C-u>Denite dein<CR>
  " Repositories managed by 'ghq'
  nnoremap <silent> <Leader>Dg  :<C-u>Denite ghq<CR>
endfunction

function! rc#plugin#denite#hook_source() abort
  " Keymapping for denite/insert mode
  call denite#custom#map('insert', '<C-a>', '<denite:move_caret_to_head>', 'noremap')
  call denite#custom#map('insert', '<C-b>', '<denite:move_caret_to_left>', 'noremap')
  call denite#custom#map('insert', '<C-d>', '<denite:delete_char_under_caret>', 'noremap')
  call denite#custom#map('insert', '<C-e>', '<denite:move_caret_to_tail>', 'noremap')
  call denite#custom#map('insert', '<C-f>', '<denite:move_caret_to_right>', 'noremap')
  call denite#custom#map('insert', '<C-h>', '<denite:delete_char_before_caret>', 'noremap')
  " <C-n>, <C-p> are mapped by default to recall command-line history.
  " Use <S-Down> and <S-Up> for these operations.
  call denite#custom#map('insert', '<C-n>', '<denite:move_to_next_line>', 'noremap')
  call denite#custom#map('insert', '<C-p>', '<denite:move_to_previous_line>', 'noremap')
  call denite#custom#map('insert', '<C-r>', '<denite:toggle_matchers:matcher_substring>', 'noremap')
  call denite#custom#map('insert', '<C-s>', '<denite:toggle_sorters:sorter_reverse>', 'noremap')
  " <C-g> to quit denite
  call denite#custom#map('insert', '<C-g>', '<denite:leave_mode>', 'noremap')
  " jj to move to normal mode
  call denite#custom#map('insert', 'jj', '<denite:enter_mode:normal>', 'noremap')

  call denite#custom#map('normal', '<C-g>', '<denite:leave_mode>', 'noremap')
  call denite#custom#map('normal', 'r', '<denite:do_action:quickfix>', 'noremap')

  " Change file/rec and grep commmand
  if executable('rg')
    call denite#custom#var('file/rec', 'command', ['rg', '--files', '--hidden', '--glob', '!.git'])
    call denite#custom#var('grep', 'command', ['rg'])
    call denite#custom#var('grep', 'default_opts', ['--vimgrep', '--no-heading'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
    call denite#custom#var('grep', 'separator', ['--'])
    call denite#custom#var('grep', 'final_opt', [])
  elseif executable('pt')
    call denite#custom#var('file/rec', 'command', ['pt', '--follow', '--nocolor', '--nogroup',
          \ '--hidden', (has('win32') ? '-g:' : '-g='), ''])
    call denite#custom#var('grep', 'command', ['pt'])
    call denite#custom#var('grep', 'default_opts', ['--nocolor', '--nogroup', '--smart-case'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'pattern_opt', [])
    call denite#custom#var('grep', 'separator', ['--'])
    call denite#custom#var('grep', 'final_opt', [])
  else
    call denite#custom#var('file/rec', 'command', ['ag', '--follow', '--nocolor', '--nogroup', '--hidden', '-g', ''])
    call denite#custom#var('grep', 'command', ['ag'])
    call denite#custom#var('grep', 'default_opts', ['-i', '--vimgrep'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'pattern_opt', [])
    call denite#custom#var('grep', 'separator', ['--'])
    call denite#custom#var('grep', 'final_opt', [])
  endif

  " Change matchers
  call denite#custom#source('file/old', 'matchers', ['matcher/fuzzy', 'matcher/project_files'])
  call denite#custom#source('tag', 'matchers', ['matcher/substring'])
  if has('nvim')
    call denite#custom#source('file/rec,grep', 'matchers', ['matcher/cpsm'])
  endif

  " Change sorters
  call denite#custom#source('file/rec', 'sorters', ['sorter_sublime'])

  " Change converters
  call denite#custom#source('file/old', 'converters', ['converter/relative_word'])

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
  call denite#custom#filter('matcher/ignore_globs', 'ignore_globs',
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
    call denite#custom#map('normal', 'R', '<denite:do_action:qfreplace>', 'noremap')
  endif

  " Display file icons in Denite* command: requires Vim-devicons
  if dein#tap('vim-devicons')
    call denite#custom#source('file/rec,file/old,buffer,directory_rec',
          \ 'converters', ['devicons_denite_converter'])
  endif
endfunction

