" ~/.vim/rc/init.vim

" Environment variables {{{1
" -----
let $VIM_CONFIG_HOME = $HOME . '/.vim'
let $VIM_DATA_HOME   = $HOME . '/.local/share/vim'
let $VIM_CACHE_HOME  = $HOME . '/.cache/vim'
" }}}1

" Set autocmds {{{1
" -----
augroup MyAutoCmd
  autocmd!
  autocmd FileType,Syntax,BufNewFile,BufNew,BufRead *? call s:on_filetype()
augroup END
" }}}1

" Local functions {{{1
" -----
" Enforce to re-detect filetype
function! s:on_filetype() abort
  if execute('filetype') =~# 'OFF'
    " Lazy loading
    silent! filetype plugin indent on
    syntax enable
    filetype detect
  endif
endfunction
" }}}1

" Setup plugin manager {{{1
" -----
" Directory path where dein.vim is located
let s:dein_dir      = $VIM_DATA_HOME . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" Install dein.vim from github repository if s:dein_dir does not exist
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . s:dein_repo_dir
endif

" Set variables for controling dein.vim
let g:dein#install_github_api_token = $DEIN_GITHUB_API_TOKEN
let g:dein#install_max_processes = 16
let g:dein#install_progress_type = 'title'
let g:dein#install_log_filename = $VIM_CACHE_HOME . '/dein.log'
" let g:dein#enable_notification = v:true
" Disable auto_recache in windows
let g:dein#auto_recache = !has('win32')

" Load dein's state from the chache script
"   REMARK: It overwrites 'runtimepath' completely.
if dein#min#load_state(s:dein_dir)
  let g:dein#inline_vimrcs = [
        \ $VIM_CONFIG_HOME . '/rc/options.vim',
        \ $VIM_CONFIG_HOME . '/rc/mappings.vim', 
        \ ]

  let s:dein_toml = $VIM_CONFIG_HOME . '/rc/dein.toml'
  let s:dein_lazy_toml = $VIM_CONFIG_HOME . '/rc/dein_lazy.toml'
  " let s:dein_ftplugin_toml = $VIM_CONFIG_HOME . '/rc/dein_ftplugin.toml'
  " let s:dein_ddc_toml = $VIM_CONFIG_HOME . '/rc/dein_ddc.toml'
  " let s:dein_ddu_toml = $VIM_CONFIG_HOME . '/rc/dein_ddu.toml'

  call dein#begin(s:dein_dir, [
        \ expand('<sfile>'),
        \ s:dein_toml,
        \ s:dein_lazy_toml,
        \ ])

  call dein#load_toml(s:dein_toml,      {'lazy': 0})
  call dein#load_toml(s:dein_lazy_toml, {'lazy': 1})
  " call dein#load_toml(s:dein_ddc_toml,  {'lazy': 1})
  " call dein#load_toml(s:dein_ddu_toml,  {'lazy': 1})
  " call dein#load_toml(s:dein_ftplugin_toml)

  " End dein configuration block
  "   REMARK: 'runtimepath' is changed after dein#end()
  call dein#end()
  call dein#save_state()
endif
" }}}1

" Detect filetype for the file given by arguments
if !empty(argv())
  call s:on_filetype()
endif

" Do not allow run some commands from vimrc or exrc when they are not owned by
" you. You better set 'secure' at the end of .vimrc or init.vim
set secure

"-----------------------------------------------------------------------------
" vim: foldmethod=marker
