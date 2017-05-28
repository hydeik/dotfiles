"----------------------------------------------------------------------------
" Environments
"----------------------------------------------------------------------------
" Store config and cache directories
let s:config_home = empty($XDG_CONFIG_HOME) ? expand('~/.config') : $XDG_CONFIG_HOME
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME

" Set python path (required to setup some plugins)
let g:python3_host_prog = $PYENV_ROOT . '/versions/miniconda3-latest/envs/neovim3/bin/python3'
let g:python_host_prog  = $PYENV_ROOT . '/versions/miniconda3-latest/envs/neovim2/bin/python'

"----------------------------------------------------------------------------
" Dein.vim -- Dark powered Vim/Neovim plugin manager.
"----------------------------------------------------------------------------
" Path to dein.vim directory
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
  let s:toml = s:config_home . '/nvim/dein.toml'
  let s:lazy_toml = s:config_home . '/nvim/dein_lazy.toml'
  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

"----------------------------------------------------------------------------
" Basic
"----------------------------------------------------------------------------
if &compatible
  set nocompatible
endif

filetype plugin indent on
syntax enable

set ignorecase
set smartcase
set wrapscan
" set number
set list
set showmatch
set laststatus=2
set noshowmode

set clipboard=unnamed,unnamedplus

" Indent
set autoindent
set smartindent
set cindent

set smarttab
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

"----------------------------------------------------------------------------
" Color scheme and themes
"----------------------------------------------------------------------------
" colorscheme dracula
set background=dark
colorscheme dracula
execute 'source' fnameescape(s:config_home . '/nvim/lightline.rc.vim')

"----------------------------------------------------------------------------
" Keymapping
"----------------------------------------------------------------------------
" Stop highlighting
nnoremap <silent><ESC><ESC> :<C-u>set nohlsearch<CR>
