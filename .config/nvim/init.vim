" ~/.config/nvim/init.vim

if &compatible
  set nocompatible
endif

" Reset autocmd
augroup MyAutoCmd
    autocmd!
augroup END

"----------------------------------------------------------------------------
" Encoding
"----------------------------------------------------------------------------
set encoding=utf-8
scriptencoding utf-8

"----------------------------------------------------------------------------
" Environments
"----------------------------------------------------------------------------
" Store config and cache directories
let s:config_home = empty($XDG_CONFIG_HOME) ? expand('~/.config') : $XDG_CONFIG_HOME
let s:cache_home  = empty($XDG_CACHE_HOME)  ? expand('~/.cache')  : $XDG_CACHE_HOME

" Set python2/python3 interpretor (required to setup some plugins)
let s:workon_home = empty($WORKON_HOME) ? expand('~/.virtualenv') : $WORKON_HOME
let g:python3_host_prog = s:workon_home . '/neovim3/.venv/bin/python3'
let g:python_host_prog  = s:workon_home . '/neovim2/.venv/bin/python2'

" Stop highlighting
nnoremap <silent><ESC><ESC> :<C-u>set nohlsearch<CR>

" "----------------------------------------------------------------------------
" " Color scheme and themes
" "----------------------------------------------------------------------------
" 
" set termguicolors
" 
" " colorscheme dracula
" set background=dark
" " colorscheme dracula
" execute 'source' fnameescape(s:config_home . '/nvim/lightline.rc.vim')

"----------------------------------------------------------------------------
" Dein.vim -- Dark powered Vim/Neovim plugin manager.
"----------------------------------------------------------------------------
" Path to dein.vim directory
let s:dein_dir      = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" Install dein.vim from github repository if dein_dir does not exist
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . s:dein_repo_dir
endif

let s:toml      = s:config_home . '/nvim/dein.toml'
let s:lazy_toml = s:config_home . '/nvim/dein_lazy.toml'

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)  " execute ':filetype off' automatically
  " Configuration file for plugins
  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()              " 'runtimepath' is changed after dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

"----------------------------------------------------------------------------
" Basic setting
"----------------------------------------------------------------------------

filetype plugin indent on
syntax on " sytax on|enable should be set after setting whole 'runtimepath'

" Load vim scripts inside './rc'
let s:rc_dir = s:config_home . '/nvim/rc'
function! s:source_rc(file)
  let rc_file = s:rc_dir . '/' . a:file
  if filereadable(rc_file)
    execute 'source ' rc_file
  endif
endfunction

call s:source_rc('options.vim')

