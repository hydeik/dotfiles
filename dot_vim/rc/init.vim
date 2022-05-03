" ~/.vim/init.vim -- My Vim configuration

"------------------------------------------------------------------------------
" Utility functions
function! s:on_filetype() abort
  if execute('filetype') !~# 'OFF'
    return
  endif
  filetype plugin indent on
  syntax enable
  " Note: filetype detect does not work on startup
  filetype detect
endfunction


"------------------------------------------------------------------------------
" Set the augroup used in vimrc.

augroup MyAutoCmd
  autocmd!
  autocmd FileType,Syntax,BufNewFile,BufNew,BufRead *?  call s:on_filetype()
augroup END


"---------------------------------------------------------------------------
" Global variables

let $VIM_CONFIG_DIR = expand('~/.vim')
let $VIM_CACHE_DIR = expand('~/.cache/vim')
if !isdirectory($VIM_CACHE_DIR)
  call mkdir($VIM_CACHE_DIR, 'p')
endif


"---------------------------------------------------------------------------
" Configure with dein.vim

let s:dein_cache_dir = $VIM_CACHE_DIR . '/dein'
let s:dein_repo_dir = $VIM_CACHE_DIR . '/dein/repos/github.com/Shougo/dein.vim'

"-- Load dein.vim. Download dein.vim from its GitHub repository beforehand
"   if it is not installed.
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . substitute(
        \ fnamemodify(s:dein_repo_dir, ':p') , '[/\\]$', '', '')
endif

"-- Configure dein.vim

" In Windows, auto_recache is disabled.  It is too slow.
let g:dein#auto_recache = !has('win32')
let g:dein#auto_remote_plugins = v:false
let g:dein#enable_notification = v:true
let g:dein#install_check_diff = v:true
let g:dein#install_check_remote_threshold = 24 * 60 * 60
let g:dein#install_max_processes = 16
let g:dein#install_progress_type = 'floating'
let g:dein#lazy_rplugins = v:true

" Load dein's state from the cached script.
"   REMARK: dein{#min}#load_state overwrites 'runtimepath' completely.
if dein#min#load_state(s:dein_cache_dir)
  " Reaches here if the cache script is old, invalid, or not found.
  " Now initialize dein.vim and start plugin configuration block.
  let s:base_dir = fnamemodify(expand('<sfile>'), ':h') . '/'
  let s:dein_toml_dir = s:base_dir . 'dein/'

  " Cache my vimrc scripts
  let g:dein#inline_vimrcs = [
        \ s:base_dir . 'envs.vim',
        \ s:base_dir . 'options.vim',
        \ s:base_dir . 'mappings.vim',
        \ ]
  if !has('gui_running')
    call add(g:dein#inline_vimrcs, s:base_dir . 'terminal.vim')
  endif

  let s:dein_toml = s:dein_toml_dir . 'plugins.toml'
  let s:dein_lazy_toml = s:dein_toml_dir . 'plugins_lazy.toml'
  let s:dein_ftplugin_toml = s:dein_toml_dir . 'ftplugin.toml'
  let s:dein_ddc_toml = s:dein_toml_dir . 'ddc.toml'
  let s:dein_ddu_toml = s:dein_toml_dir . 'ddu.toml'

  call dein#begin(s:dein_cache_dir, [
        \ expand('<sfile>'),
        \ s:dein_toml,
        \ s:dein_lazy_toml,
        \ s:dein_ddc_toml,
        \ s:dein_ddu_toml,
        \ s:dein_ftplugin_toml,
        \ ])

  call dein#load_toml(s:dein_toml, {'lazy': 0})
  call dein#load_toml(s:dein_lazy_toml, {'lazy' : 1})
  call dein#load_toml(s:dein_ddc_toml, {'lazy' : 1})
  call dein#load_toml(s:dein_ddu_toml, {'lazy' : 1})
  call dein#load_toml(s:dein_ftplugin_toml)

  " End dein configuration block
  "   REMARK: 'runtimepath' is changed after dein#end()
  call dein#end()
  call dein#save_state()

  " Install missing plugin(s) automatically
  if has('vim_starting') && dein#check_install()
    call dein#install()
  endif
endif


"---------------------------------------------------------------------------
" End of configuration

" Handling argument(s)
if !empty(argv())
  call s:on_filetype()
endif

" Do not allow run some commands from vimrc or exrc when they are not owned
" by you. You better set 'secure' at the end of .vimrc or init.vim
set secure
