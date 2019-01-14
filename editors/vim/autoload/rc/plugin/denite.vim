function! s:get_selection(cmdtype) abort
  let l:temp = @s
  normal! gv"sy
  let @/ = substitute(escape(@s, '\'.a:cmdtype), '\n', '\\n', 'g')
  let @s = l:temp
endfunction

function! rc#plugin#denite#hook_add() abort
  " --- Key mappings
  " use ';' key as the Denite prefix
  nnoremap [Denite] <Nop>
  nmap ;   [Denite]

  " Substitute search commands by Denite line
  nnoremap <silent> / :<C-u>Denite line -buffer-name=search -auto-highlight<CR>
  nnoremap <silent> * :<C-u>DeniteCursorWord line -buffer-name=search -auto-highlight -mode=normal<CR>
  nnoremap <silent> n :<C-u>Denite -resume -buffer-name=search -auto-highlight -mode=normal -refresh<CR>

  " switch buffers
  nnoremap <silent> [Denite]b  :<C-u>Denite buffer file/old -default-action=switch -mode=normal<CR>
  " find file
  nnoremap <silent> [Denite]f  :<C-u>Denite file/point file/old
        \ `finddir('.git', ';') != '' ? 'file/rec/git' : 'file/rec'`
        \ file file:new<CR> -sorters=sorter/rank
  " Grep
  nnoremap <silent> [Denite]g  :<C-u>Denite grep -no-empty -buffer-name=search -mode=normal<CR>
  nnoremap <silent> [Denite]*  :<C-u>DeniteCursorWord grep -no-empty -buffer-name=search -mode=normal<CR>
  vnoremap <silent> [Denite]*  :<C-u>call <SID>get_selection('/')<CR>
        \ :execute 'Denite grep:::'.@/.' -no-empty -buffer-name=search -mode=normal'<CR><CR>
  " Help
  nnoremap <silent> [Denite]h  :<C-u>Denite help<CR>
  " jump
  nnoremap <silent> [Denite]j  :<C-u>Denite jump change file/point<CR>
  " Location list
  nnoremap <silent> [Denite]l  :<C-u>Denite location_list -buffer-name=list<CR>
  " outline
  nnoremap <silent> [Denite]o  :<C-u>Denite outline<CR>
  " Resume
  nnoremap <silent> [Denite]r  :<C-u>Denite -resume<CR>
  " Tag jump (previous)
  nnoremap <silent><expr> [Denite]p  &filetype == 'help' ? ":\<C-u>pop\<CR>" :
        \ ":\<C-u>Denite -mode=normal jump\<CR>"
  " Quickfix list
  nnoremap <silent> [Denite]q  :<C-u>Denite quickfix -buffer-name=list<CR>
  " Sessions
  nnoremap <silent> [Denite]s  :<C-u>Denite session -buffer-name=list<CR>
  " Tag jump (next)
  nnoremap <silent><expr> [Denite]t  &filetype == 'help' ? "g\<C-]>" :
        \ ":\<C-u>DeniteCursorWord -buffer-name=tag tag:include\<CR>"
  " Junkfiles
  nnoremap <silent> [Denite]u  :<C-u>Denite junkfile:new junkfile<CR>
  " register / neoyank
  nnoremap <silent> [Denite]y  :<C-u>Denite register neoyank -buffer-name=register<CR>
  xnoremap <silent> [Denite]y  :<C-u>Denite register neoyank -buffer-name=register -default-action=replace<CR>
  " Command/command history
  nnoremap <silent> [Denite];  :<C-u>Denite command command_history<CR>

  " Plugins managed by 'Dein'
  nnoremap <silent> [Denite]N  :<C-u>Denite dein<CR>
  " Repositories managed by 'ghq'
  nnoremap <silent> [Denite]P  :<C-u>Denite ghq<CR>
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
  call denite#custom#map('insert', 'jj',    '<denite:enter_mode:normal>', 'noremap')

  call denite#custom#map('normal', '<C-n>', '<denite:move_to_next_line>', 'noremap')
  call denite#custom#map('normal', '<C-p>', '<denite:move_to_previous_line>', 'noremap')
  call denite#custom#map('normal', '<C-g>', '<denite:leave_mode>', 'noremap')
  call denite#custom#map('normal', 'r',     '<denite:do_action:quickfix>', 'noremap')

  " Change file/rec and directory_rec command
  if executable('fd')
    call denite#custom#var('file/rec', 'command', ['fd', '--type', 'file', '--follow', '--full-path', '--hidden', '--exclude', '.git'])
    call denite#custom#var('directory_rec', 'command', ['fd', '--type', 'directory', '--full-path', '--follow', '--hidden'])
  elseif executable('rg')
    call denite#custom#var('file/rec', 'command', ['rg', '--files', '--hidden', '--glob', '!.git'])
  elseif executable('ag')
    call denite#custom#var('file/rec', 'command', ['ag', '--follow', '--nocolor', '--nogroup', '--hidden', '-g', ''])
  endif

  " Change grep commmand
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

  " Change matchers
  call denite#custom#source('file/rec', 'matchers', ['matcher/fruzzy'])
  call denite#custom#source('file/old', 'matchers', ['matcher/fruzzy', 'matcher/project_files'])
  call denite#custom#source('tag', 'matchers', ['matcher/substring'])

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

