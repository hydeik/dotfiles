"----------------------------------------------------------------------------
" ~/.config/nvim/rc/dein.vim -- configure dein.vim plugin manager

" Set variables for controling dein.vim
let g:dein#install_max_processes = 16
let g:dein#install_progress_type = 'echo'
let g:dein#enable_notification = 0
let g:dein#install_log_filename = $VIM_CACHE_HOME . '/dein/dein.log'

" Get directory path where dein.vim is located
let s:dein_dir      = $VIM_CACHE_HOME . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" Install dein.vim from github repository if dein_dir does not exist
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . s:dein_repo_dir
endif

" Load dein's state from the chache script
"   REMARK: It overwrites 'runtimepath' completely.
if !dein#load_state(s:dein_dir)
  finish
endif

" Reaches here if the cache script is old, invalid, or not found.
" Now initialize dein.vim and start plugin configuration block.
let s:base       = $VIM_CONFIG_HOME . '/rc/dein/'
let s:plugins_toml = s:base . 'plugins.toml'
let s:plugins_lazy_toml = s:base . 'plugins_lazy.toml'
let s:ftplugin_toml = s:base . 'ftplugin.toml'
" let s:toml_files = [
"       \ { 'name': 'plugins.toml',        'lazy': 0 },
"       \ { 'name': 'plugins_lazy.toml',   'lazy': 1 },
"       \ { 'name': 'ftplugin.toml',       'lazy': 0 },
"       \ ]

call dein#begin(s:dein_dir, [expand('<sfile>'), s:plugins_toml, s:plugins_lazy_toml, s:ftplugin_toml])
call dein#load_toml(s:plugins_toml,      {'lazy': 0})
call dein#load_toml(s:plugins_lazy_toml, {'lazy': 1})
call dein#load_toml(s:ftplugin_toml,     {'lazy': 0})
" call dein#begin(s:dein_dir)
" for t in s:toml_files
"   call dein#load_toml(s:base . t['name'], {'lazy': t['lazy']})
" endfor

" End dein configuration block
"   REMARK: 'runtimepath' is changed after dein#end()
call dein#end()
call dein#save_state()

" Install missing plugin(s) automatically
if has('vim_starting') && dein#check_install()
  call dein#install()
endif
