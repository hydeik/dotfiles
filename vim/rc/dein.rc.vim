"----------------------------------------------------------------------------
" Dein.vim -- Dark powered Vim/Neovim plugin manager.
"----------------------------------------------------------------------------
" Path to dein.vim directory

let s:base = fnamemodify(expand('<sfile>'), ':p:h')

let s:dein_dir      = $XDG_CACHE_HOME . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" Install dein.vim from github repository if dein_dir does not exist
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . s:dein_repo_dir
endif

let s:toml      = s:base . '/dein.toml'
let s:lazy_toml = s:base . '/dein_lazy.toml'

if !dein#load_state(s:dein_dir)
  finish
endif

call dein#begin(s:dein_dir)  " execute ':filetype off' automatically
" Configuration file for plugins
call dein#load_toml(s:toml, {'lazy': 0})
call dein#load_toml(s:lazy_toml, {'lazy': 1})

call dein#end()              " 'runtimepath' is changed after dein#end()
call dein#save_state()

if !has('vim_starting')
  if dein#check_install()
    call dein#install()
  endif

  "call dein#recache_runtimepath()

  "call dein#call_hook('add')
  "call dein#call_hook('source')
  "call dein#call_hook('post_source')
endif

autocmd MyVimrc VimEnter * call dein#call_hook('post_source')
