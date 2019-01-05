" Vim startup settings

"----------------------------------------------------------------------------
" Utility function
"----------------------------------------------------------------------------
" {{{
" Query OS type
let s:is_windows = has('win32') || has('win64')

function! IsWindows() abort
  return s:is_windows
endfunction

function! IsMac() abort
  return !s:is_windows && !has('win32unix')
        \ && (has('mac') || has('macunix') || has('gui_macvim')
        \     || (!executable('xdg-open') && system('uname') =~? '^darwin'))
endfunction

" mkdir
if has('nvim')
  let s:mkdir = function('mkdir')
else
  function! s:mkdir(...) abort
    if isdirectory(a:1)
      return
    endif
    return call('mkdir', a:000)
  endfunction
endif

" Set executable path and manpath.
" NOTE: These variables might not be set properly in GVim/MacVim
function! s:configure_path(name, pathlist) abort
  let l:path_separator = s:is_windows ? ';' : ':'
  let l:pathlist = split(expand(a:name), l:path_separator)
  for l:path in map(filter(a:pathlist, '!empty(v:val)'), 'expand(v:val)')
    if isdirectory(l:path) && index(l:pathlist, l:path) == -1
      call insert(l:pathlist, l:path, 0)
    endif
  endfor
  execute printf('let %s = join(pathlist, ''%s'')', a:name, l:path_separator)
endfunction
" }}}

"----------------------------------------------------------------------------
" Language, encodings
"----------------------------------------------------------------------------
" {{{
" Setting of the encoding to use for a save and reading.
" Make it normal in UTF-8 in Unix.
if has('vim_starting') && &encoding !=# 'utf-8'
  if IsWindows() && !has('gui_running')
    " For windows command line prompt
    set encoding=cp932
  else
    set encoding=utf-8
  endif
endif

scriptencoding utf-8

" Build encodings.
let &fileencodings = join(['ucs-bom', 'iso-2022-jp-3', 'utf-8', 'euc-jp',
      \                    'cp932', 'utf-16', 'utf-16le', 'cp1250'])

" Setting of terminal encoding.
if !has('gui_running') && IsWindows()
  " For system.
  set termencoding=cp932
endif

if has('multi_byte_ime')
  set iminsert=0 imsearch=0
endif
" }}}

"----------------------------------------------------------------------------
" Environment variables
"----------------------------------------------------------------------------
" {{{
" XDG Base Directory Specification
if empty($XDG_CONFIG_HOME)
  let $XDG_CONFIG_HOME = expand('~/.config')
endif

if empty($XDG_CACHE_HOME)
  let $XDG_CACHE_HOME = expand('~/.cache')
endif

if empty($XDG_DATA_HOME)
  let $XDG_DATA_HOME = expand('~/.local/share')
endif

let $PYENV_ROOT = expand('~/.anyenv/envs/pyenv')

" Set PATH variable
" TODO: add configuration for Windows
call s:configure_path('$PATH', [
      \ '~/.local/bin',
      \ '~/.yarn/bin',
      \ '~/.cargo/bin',
      \ '~/.nodenv/bin',
      \ '~/.rbenv/bin',
      \ '~/.pyenv/bin',
      \ '~/.nodenv/shims/bin',
      \ '~/.rbenv/shims/bin',
      \ '~/.pyenv/shims/bin',
      \ '~/.anyenv/envs/ndenv/bin',
      \ '~/.anyenv/envs/rbenv/bin',
      \ '~/.anyenv/envs/pyenv/bin',
      \ '~/.anyenv/envs/nodenv/shims',
      \ '~/.anyenv/envs/rbenv/shims',
      \ '~/.anyenv/envs/pyenv/shims',
      \ '~/.zplug/bin',
      \ '~/bin',
      \ '/Library/Tex/texbin',
      \ '/usr/local/bin',
      \ '/usr/bin',
      \ '/bin',
      \ '/usr/local/sbin',
      \ '/usr/sbin',
      \ '/sbin',
      \])
call s:configure_path('$MANPATH', [
      \ '/usr/local/share/man/',
      \ '/usr/share/man/',
      \ '/opt/intel/man/',
      \ '/Applications/Xcode.app/Contents/Developer/usr/share/man',
      \ '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/share/man',
      \])

"
" Set python2/python3 interpretor (required to setup plugins using neovim
" python API)
"
" Create virtualenvs for and only for neovim (+ development tools) and set
" python3_host_prog and python_host_prog to point the corresponding python
" interpreters.
"
if has('nvim')
  let g:python3_host_prog = $PYENV_ROOT . '/versions/neovim3/bin/python'
  let g:python_host_prog  = $PYENV_ROOT . '/versions/neovim2/bin/python'
endif

" --- Directories for Vim files
if has('nvim')
  let $VIM_CONFIG_HOME = $XDG_CONFIG_HOME . '/nvim'
  let $VIM_DATA_HOME   = $XDG_DATA_HOME   . '/nvim'
  let $VIM_CACHE_HOME  = $XDG_CACHE_HOME  . '/nvim'
else
  let $VIM_CONFIG_HOME = $XDG_CONFIG_HOME . '/vim'
  let $VIM_DATA_HOME   = $XDG_DATA_HOME   . '/vim'
  let $VIM_CACHE_HOME  = $XDG_CACHE_HOME  . '/vim'
  " update runtime path
  set runtimepath=$VIM_CONFIG_HOME,$VIMRUNTIME,$VIM_CONFIG_HOME/after
endif

" backup files
set backupdir=$VIM_CACHE_HOME/backup
" swap files
set directory=$VIM_CACHE_HOME/swap
" undo files
set undodir=$VIM_CACHE_HOME/undo
" files for |:mkview|
set viewdir=$VIM_CACHE_HOME/view
" spell file
set spellfile=$VIM_DATA_HOME/spell/en.utf-8.add
" viminfo/shada
"   ' - Maximum number of previously edited files marks
"   f - 1: store global marks (A-Z and 0-9), 0: nothing is stored
"   < - number of lines saved for each register
"   s - maximum size of an item contents in KiB
"   : - number of lines to save from the command line history
"   @ - number of lines to save from the input line history
"   / - number of lines to save from the search history
"   r - removable media, for which no marks will be stored
"       (can be used several times)
"   ! - global variables that start with an uppercase letter and
"       don't contain lowercase letters
"   h - disable 'hlsearch' highlighting when starting
"   % - the buffer list (only restored when starting Vim w/o file arguments)
"   c - convert the text using 'encoding'
"   n - name used for the ShaDa file (must be the last option)
if has('nvim')
  " stored to $XDG_DATA_HOME/nvim/shada/main.shada by default
  set shada='1000,<50,@100,s10,h
else
  " stored to ~/.viminfo by default
  set viminfo='1000,<20,@50,h,n$VIM_CACHE_HOME/viminfo
endif

call s:mkdir(&backupdir, 'p')
call s:mkdir(&directory, 'p')
call s:mkdir(&undodir, 'p')
call s:mkdir(&viewdir, 'p')
call s:mkdir(fnamemodify(&spellfile, ':p:h'), 'p')

" Disable packpath
set packpath=
" }}}

"----------------------------------------------------------------------------
" Options
"----------------------------------------------------------------------------
" {{{
" Disable annoying bells
set noerrorbells
set novisualbell t_vb=
if exists('&belloff')
  set belloff=all
endif

" Do not wait more than 100 ms for keys
set timeout
set ttimeout
set ttimeoutlen=100
" }}}

"----------------------------------------------------------------------------
" Prefix keys
"----------------------------------------------------------------------------
" {{{
" Use 'space' as <Leader> key and ',' as <LocalLeader> key
" REMARK: Required before loading plugins!
let g:mapleader = "\<Space>"
let g:maplocalleader = ','

" Release some keymappings for use of plugins
"   Space -> Leader
"   ,     -> LocalLeader
"   ;     -> prefix for Denite commands
"   s     -> prefix for window, tab, easymotion
nnoremap <Space>  <Nop>
xnoremap <Space>  <Nop>
nnoremap ,  <Nop>
xnoremap ,  <Nop>
nnoremap ;  <Nop>
xnoremap ;  <Nop>
nmap     s  <Nop>
xmap     s  <Nop>
" }}}

"----------------------------------------------------------------------------
" Disable default plugins
"----------------------------------------------------------------------------
" {{{
let g:loaded_2html_plugin      = 1
let g:loaded_getscript         = 1
let g:loaded_getscriptPlugin   = 1
let g:loaded_gzip              = 1
let g:loaded_logiPat           = 1
let g:loaded_matchit           = 1
let g:loaded_matchparen        = 1
let g:netrw_nogx               = 1
let g:loaded_netrwPlugin       = 1
let g:loaded_netrwSettings     = 1
let g:loaded_netrwFileHandlers = 1
let g:loaded_rrhelper          = 1
let g:loaded_spellfile_plugin  = 1
let g:loaded_tar               = 1
let g:loaded_tarPlugin         = 1
let g:loaded_vimball           = 1
let g:loaded_vimballPlugin     = 1
let g:loaded_zip               = 1
let g:loaded_zipPlugin         = 1
" Disable ruby support in neovim
let g:loaded_ruby_provider     = 1
" }}}

"----------------------------------------------------------------------------
" vim: expandtab softtabstop=2 shiftwidth=2 foldmethod=marker
