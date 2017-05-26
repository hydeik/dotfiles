" Show line number
set number

" TrueColor support (optional)
" set termguicolors

" Clipboard (See "help: clipboard" for more details)
set clipboard=unnamed,unnamedplus

" ***** Plugins *****

" Dein.vim -- Dark powered Vim/Neovim plugin manager.
" dein settings {{{
if &compatible
    set nocompatible
endif
" Path to dein.vim directory
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
" Install dein.vim from github repository if dein_dir does not exist
if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
endif
execute 'set runtimepath^=' . s:dein_repo_dir

if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)
    " Configuration file for plugins
    let s:toml = '~/.config/nvim/dein.toml'
    let s:lazy_toml = '~/.config/nvim/dein_lazy.toml'
    call dein#load_toml(s:toml, {'lazy': 0})
    call dein#load_toml(s:lazy_toml, {'lazy': 1})

    call dein#end()
    call dein#save_state()
endif

if dein#check_install()
    call dein#install()
endif
" }}}

filetype plugin indent on
syntax enable
"colorscheme dracula
source ~/.config/nvim/lightline.rc.vim
