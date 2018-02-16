" ~/.config/nvim/init.vim

if &compatible
  set nocompatible
endif

" Reset autocmd
augroup MyVimrc
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
let s:config_home = empty($XDG_CONFIG_HOME) ? expand('~/.config')      : $XDG_CONFIG_HOME
let s:cache_home  = empty($XDG_CACHE_HOME)  ? expand('~/.cache')       : $XDG_CACHE_HOME
let s:data_home   = empty($XDG_DATA_HOME)   ? expand('~/.local/share') : $XDG_DATA_HOME

"
" Set python2/python3 interpretor (required to setup plugins using neovim
" python API)
"
" Create virtualenvs for and only for neovim (+ development tools) and set
" python3_host_prog and python_host_prog to point the corresponding python
" interpreters.
"
let g:python3_host_prog = $PYENV_ROOT . '/versions/neovim3/bin/python'
let g:python_host_prog  = $PYENV_ROOT . '/versions/neovim2/bin/python'

"----------------------------------------------------------------------------
" Utility function(s)
"----------------------------------------------------------------------------
" Load vim scripts inside 'nvim/rc'

let s:rc_dir = s:config_home . '/nvim/rc'
function! s:source_rc(file)
  let rc_file = s:rc_dir . '/' . a:file
  if filereadable(rc_file)
    execute 'source ' rc_file
  endif
endfunction

"----------------------------------------------------------------------------
" Leader and Localleader keys
"----------------------------------------------------------------------------
let g:mapleader = "\<Space>"
let g:maplocalleader = ','

if !empty('g:lmap')
  let g:lmap = {}
endif

if !empty('g:llmap')
  let g:llmap = {}
endif

"----------------------------------------------------------------------------
" Load confituration files
"----------------------------------------------------------------------------
call s:source_rc('encoding.rc.vim')

call s:source_rc('options.rc.vim')

call s:source_rc('mappings.rc.vim')

call s:source_rc('dein.rc.vim')

filetype plugin indent on
syntax on " sytax on|enable should be set after setting whole 'runtimepath'

call s:source_rc('colorscheme.rc.vim')

" Do not allow run some commands from vimrc or exrc when they are not owned by
" you. You better set 'secure' at the end of .vimrc or init.vim
set secure

