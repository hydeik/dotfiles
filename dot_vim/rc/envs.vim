"-----------------------------------------------------------------------------
" ~/.vim/rc/envs.vim
"-----------------------------------------------------------------------------

" Utility function to set executable path variables
function! s:configure_path(name, pathlist) abort
  let l:path_separator = has('win32') ? ';' : ':'
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
      \ '~/.poetry/bin',
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
      \ '~/bin',
      \ '/Library/Tex/texbin',
      \ '/usr/local/bin',
      \ '/usr/bin',
      \ '/bin',
      \ '/usr/local/sbin',
      \ '/usr/sbin',
      \ '/sbin',
      \ ])
