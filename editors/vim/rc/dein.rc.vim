"----------------------------------------------------------------------------
" Dein.vim -- Dark powered Vim/Neovim plugin manager.
"----------------------------------------------------------------------------
" Path to dein.vim directory

let s:base = fnamemodify(expand('<sfile>'), ':p:h')

let s:dein_dir      = $VIM_CACHE_HOME . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" Install dein.vim from github repository if dein_dir does not exist
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . s:dein_repo_dir
endif

let s:dein_toml      = s:base . '/dein.toml'
let s:dein_toml_lazy = s:base . '/dein_lazy.toml'
let s:dein_toml_ft   = s:base . '/dein_ftplugin.toml'

if !dein#load_state(s:dein_dir)
  finish
endif

call dein#begin(s:dein_dir, expand('<sfile>'))
" Configuration file for plugins
call dein#load_toml(s:dein_toml,      {'lazy': 0})
call dein#load_toml(s:dein_toml_lazy, {'lazy': 1})
call dein#load_toml(s:dein_toml_ft)

call dein#end()              " 'runtimepath' is changed after dein#end()
call dein#save_state()

if has('vim_starting') && dein#check_install()
  " Install plugin(s) automatically if necessary
  call dein#install()
endif

"----------------------------------------------------------------------------
" vim: expandtab softtabstop=2 shiftwidth=2 foldmethod=marker
