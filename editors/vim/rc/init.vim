"-----------------------------------------------------------------------------
" ~/.config/nvim/rc/init.rc.vim Vim startup settings
"-----------------------------------------------------------------------------

" Language, encodings, options {{{
" -----
" Setting of the encoding to use for a save and reading.
set encoding=utf-8
scriptencoding utf-8

" List of character encodings considered when starting to edit an existing file
set fileencodings=ucs-bom,utf-8,euc-jp,iso-2022-jp,cp932,utf-16,utf-16le,cp1250

" Setting of terminal encoding.
if !has('gui_running') && IsWindows()
  " For system.
  set termencoding=cp932
endif

if has('multi_byte_ime')
  set iminsert=0 imsearch=0
endif

" Use forwardslash '/' when expanding file names (only on Windows)
if exists('+shellslash')
  set shellslash
endif
" }}}

" Ensure cache and data directories {{{
" -----
call mkdir(expand('$VIM_CACHE_HOME/backup'), 'p')
call mkdir(expand('$VIM_CACHE_HOME/swap'), 'p')
call mkdir(expand('$VIM_CACHE_HOME/undo'), 'p')
call mkdir(expand('$VIM_CACHE_HOME/view'), 'p')
call mkdir(expand('$VIM_CACHE_HOME/session'), 'p')
call mkdir(expand('$VIM_DATA_HOME/spell'), 'p')
" }}}

" Prefix keys {{{
" -----
" Use ';' as <Leader> key and ',' as <LocalLeader> key
"   REMARK: Required before loading plugins!
let g:mapleader = ";"
let g:maplocalleader = ','

" Release some keymappings for use of plugins
"   Space -> prefix for fuzzy finder
"   ;     -> <Leader> key
"   ,     -> <LocalLeader> key
"   s     -> prefix for window, tab, easymotion, sandwich
"   m     -> prefix for LSP features
nnoremap <Space>  <Nop>
xnoremap <Space>  <Nop>
nnoremap ;  <Nop>
xnoremap ;  <Nop>
nnoremap ,  <Nop>
xnoremap ,  <Nop>
nmap     s  <Nop>
xmap     s  <Nop>
nmap     m  <Nop>
xmap     m  <Nop>

" }}}

" Disable pre-bundled plugins and package system {{{
" -----
set packpath=
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

"-----------------------------------------------------------------------------
" vim: foldmethod=marker
