" ~/.config/nvim/init.vim -- configuration file for NeoVim

" Environment Variables {{{
" -----
" Makes Vim to support XDG Base Directory Specification.
" NeoVim fully supports this.
if empty("$XDG_CONFIG_HOME")
  let $XDG_CONFIG_HOME = $HOME . '/.config'
endif

if empty("$XDG_CACHE_HOME")
  let $XDG_CACHE_HOME = $HOME . '/.cache'
endif

if empty("$XDG_DATA_HOME")
  let $XDG_DATA_HOME = $HOME . '/.local/share'
endif

if has('nvim')
  let $VIM_CONFIG_HOME = $XDG_CONFIG_HOME . '/nvim'
  let $VIM_DATA_HOME   = $XDG_DATA_HOME   . '/nvim'
  let $VIM_CACHE_HOME  = $XDG_CACHE_HOME  . '/nvim'
else
  let $VIM_CONFIG_HOME = $XDG_CONFIG_HOME . '/vim'
  let $VIM_DATA_HOME   = $XDG_DATA_HOME   . '/vim'
  let $VIM_CACHE_HOME  = $XDG_CACHE_HOME  . '/vim'
  " Enforce Vim to follow XDG Base Directory Specifications
  let $MYVIMRC  = $VIM_CONFIG_HOME . '/vimrc'
  if has('gui_running')
    let $MYGVIMRC = $VIM_CONFIG_HOME . '/gvimrc'
  endif
  " update runtime path
  set runtimepath=$VIM_CONFIG_HOME,$VIMRUNTIME,$VIM_CONFIG_HOME/after
endif

" Set python2/python3 interpretor (required to setup plugins using neovim
" python API)
let $PYENV_ROOT = expand('~/.anyenv/envs/pyenv')
if has('nvim')
  " Create virtualenvs for and only for neovim (+ development tools) and set
  " python3_host_prog and python_host_prog to point the corresponding python
  " interpreters.
  let g:python3_host_prog = $PYENV_ROOT . '/versions/neovim3/bin/python'
  let g:python_host_prog  = $PYENV_ROOT . '/versions/neovim2/bin/python'
else
  if has('pythonx')
    " Prefer python3 to python2
    if has('python3')
      set pyxversion=3
    else
      set pyxversion=2
    endif
  endif
endif

" Utility functions to inquiry OS type
let s:is_windows = has('win32') || has('win64')

function! IsWindows() abort
  return s:is_windows
endfunction

function! IsMac() abort
  return !s:is_windows && !has('win32unix')
        \ && (has('mac') || has('macunix') || has('gui_macvim')
        \     || (!executable('xdg-open') && system('uname') =~? '^darwin'))
endfunction

" Utility function to set executable path variables
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

" Set PATH and MANPATH
call s:configure_path('$PATH', [
      \ '~/.local/bin',
      \ '~/.yarn/bin',
      \ '~/.cargo/bin',
      \ '~/.goenv/bin',
      \ '~/.nodenv/bin',
      \ '~/.rbenv/bin',
      \ '~/.pyenv/bin',
      \ '~/.nodenv/shims/bin',
      \ '~/.rbenv/shims/bin',
      \ '~/.pyenv/shims/bin',
      \ '~/.anyenv/envs/goenv/bin',
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
" }}}

" Set autocmd {{{
" -----
augroup MyAutoCmd
  autocmd!
  " autocmd FileType,Syntax,BufNewFile,BufNew,BufRead *?  call s:on_filetype()
  " Re-detect filetype on save
  autocmd BufWritePost *
        \ if &filetype ==# '' && exists('b:ftdetect') |
        \   unlet! b:ftdetect |
        \   filetype detect |
        \ endif
augroup END
" }}}

" Load configuration files {{{
" -----
" Load vim scripts inside 'nvim/rc'
let s:rc_base_dir = $VIM_CONFIG_HOME . '/rc'

function! s:source_rc(file)
  let l:rc_file = s:rc_base_dir . '/' . a:file
  if filereadable(l:rc_file)
    execute 'source ' l:rc_file
  endif
endfunction

" Enforce to re-detect filetype
function! s:on_filetype() abort
  if execute('filetype') =~# 'OFF'
    " Lazy loading
    silent! filetype plugin indent on
    syntax enable
    filetype detect
  endif
endfunction

" Configuration on startup
if has('vim_starting')
  call s:source_rc('init.vim')
  if !has('gui_running')
    call s:source_rc('terminal.vim')
  endif
endif

" Confiugre dein.vim plugin manager and load plugins
call s:source_rc('dein.vim')
if has('vim_starting') && !empty(argv())
  call s:on_filetype()
endif

if !has('vim_starting')
  call dein#call_hook('source')
  call dein#call_hook('post_source')
  filetype plugin indent on
  syntax enable
endif

" Other configurations
call s:source_rc('encoding.vim')
call s:source_rc('options.vim')
call s:source_rc('mappings.vim')
call s:source_rc('statusline.vim')
" }}}

" Do not allow run some commands from vimrc or exrc when they are not owned by
" you. You better set 'secure' at the end of .vimrc or init.vim
set secure

"-----------------------------------------------------------------------------
" vim: foldmethod=marker
