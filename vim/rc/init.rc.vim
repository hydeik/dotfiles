" ~/.config/nvim/init.vim

if &compatible
  set nocompatible
endif

"----------------------------------------------------------------------------
" Environments
"----------------------------------------------------------------------------
if has('vim_starting')
  " Set encoding in vim
  set encoding=utf-8
  scriptencoding utf-8
endif

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

" --- Query OS type
let s:is_windows = has('win32') || has('win64')

function! IsWindows() abort
  return s:is_windows
endfunction

function! IsMac() abort
  return !s:is_windows && !has('win32unix')
        \ && (has('mac') || has('macunix') || has('gui_macvim')
        \     || (!executable('xdg-open') && system('uname') =~? '^darwin'))
endfunction

" --- Set executable path and manpath.
" These variables might not be set properly in GVim/MacVim
function! s:configure_path(name, pathlist) abort
  let path_separator = s:is_windows ? ';' : ':'
  let pathlist = split(expand(a:name), path_separator)
  for path in map(filter(a:pathlist, '!empty(v:val)'), 'expand(v:val)')
    if isdirectory(path) && index(pathlist, path) == -1
      call insert(pathlist, path, 0)
    endif
  endfor
  execute printf('let %s = join(pathlist, ''%s'')', a:name, path_separator)
endfunction

call s:configure_path('$PATH', [
      \ '~/.local/bin',
      \ '~/.cargo/bin',
      \ '~/.ndenv/bin',
      \ '~/.rbenv/bin',
      \ '~/.plenv/bin',
      \ '~/.pyenv/bin',
      \ '~/.anyenv/envs/ndenv/bin',
      \ '~/.anyenv/envs/rbenv/bin',
      \ '~/.anyenv/envs/plenv/bin',
      \ '~/.anyenv/envs/pyenv/bin',
      \ '~/.anyenv/envs/ndenv/shims',
      \ '~/.anyenv/envs/rbenv/shims',
      \ '~/.anyenv/envs/plenv/shims',
      \ '~/.anyenv/envs/pyenv/shims',
      \ '~/.zplug/bin',
      \ '~/bin',
      \ '/Library/Tex/texbin',
      \ '/usr/local/bin',
      \ '/usr/bin',
      \ '/bin',
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
let g:python3_host_prog = $PYENV_ROOT . '/versions/neovim3/bin/python'
let g:python_host_prog  = $PYENV_ROOT . '/versions/neovim2/bin/python'

" --- Enable Vim to use system clipboard
" -> Disabled because of the problem of lectangular yank
" if has('clipboard')
"   set clipboard&   " <- set to default
"   " - unnamed     : 'selection' in X11; clipboard in Mac OS X and Windows
"   " - unnamedplus : 'clipboard' in X11, Mac OS X, and Windows (but yank)
"   if has('win32') || has('win64') || has('mac')
"     set clipboard^=unnamed
"   else
"     set clipboard^=unnamed,unnamedplus
"   endif
" endif

"----------------------------------------------------------------------------
" Utility function(s)
"----------------------------------------------------------------------------
if has('nvim')
  let g:vimrc_root = $XDG_CONFIG_HOME . '/nvim'
else
  let g:vimrc_root = $HOME . '/.vim'
endif
let s:rc_base_dir = g:vimrc_root . '/rc'

" Load vim scripts inside 'nvim/rc'
function! s:source_rc(file)
  let rc_file = s:rc_base_dir . '/' . a:file
  if filereadable(rc_file)
    execute 'source ' rc_file
  endif
endfunction

function! s:on_filetype() abort "{{{
  if execute('filetype') =~# 'OFF'
    " Lazy loading
    silent! filetype plugin indent on
    syntax enable
    filetype detect
  endif
endfunction "}}}

"----------------------------------------------------------------------------
" Set augroup
"----------------------------------------------------------------------------
augroup MyVimrc
  autocmd!
  autocmd FileType,Syntax,BufNewFile,BufNew,BufRead *?  call s:on_filetype()
  " Re-detect filetype on save
  autocmd BufWritePost *
        \ if &filetype ==# '' && exists('b:ftdetect') |
        \   unlet! b:ftdetect |
        \   filetype detect |
        \ endif
augroup END

"----------------------------------------------------------------------------
" Prefix keys
"----------------------------------------------------------------------------
noremap <Leader>       <Nop>
noremap <LocalLeader>  <Nop>
let g:mapleader = "\<Space>"
let g:maplocalleader = ','

" Release some keymappings for plugins
nnoremap ;  <Nop>
nnoremap , <Nop>
" nnoremap m  <Nop>
nnoremap s <Nop>
xnoremap s <Nop>

"----------------------------------------------------------------------------
" Load confituration files
"----------------------------------------------------------------------------
call s:source_rc('dein.rc.vim')
if has('vim_starting') && !empty(argv())
  call s:on_filetype()
endif

if !has('vim_starting')
  call dein#call_hook('source')
  call dein#call_hook('post_source')

  filetype plugin indent on
  syntax enable
endif

call s:source_rc('encoding.rc.vim')

call s:source_rc('options.rc.vim')

call s:source_rc('mappings.rc.vim')

call s:source_rc('colorscheme.rc.vim')

" Do not allow run some commands from vimrc or exrc when they are not owned by
" you. You better set 'secure' at the end of .vimrc or init.vim
set secure

