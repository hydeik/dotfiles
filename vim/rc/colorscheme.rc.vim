" colorscheme.vim --- setup colorscheme on vim/nvim
"
" depends on
"  - vim-devicon
"  - lightline.vim
"  - lightline-hybrid.vim

" terminal colors
set t_Co=256
if has('termguicolors')
  set termguicolors
endif

" --- Colorscheme
set background=dark
colorscheme dracula

" --- Customize status line with lightline
let g:lightline = {
      \ 'colorscheme': 'Dracula',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'pyenv' ],
      \             [ 'gitstatus', 'filename' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype' ] ],
      \ },
      \ 'component' : {
      \   'lineinfo': "\ue0a1 %3l:%-2v"
      \ },
      \ 'component_function': {
      \   'modified': 'LightlineModified',
      \   'readonly': 'LightlineReadonly',
      \   'gitstatus': 'LightlineGitstatus',
      \   'filename': 'LightlineFilename',
      \   'fileformat': 'LightlineFileformat',
      \   'filetype': 'LightlineFiletype',
      \   'fileencoding': 'LightlineFileencoding',
      \   'mode': 'LightlineMode',
      \   'pyenv': 'LightlinePyenv',
      \ },
      \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
      \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
      \ }

function! LightlineModified()
  if &filetype =~ "help\|vimfiler\|gundo"
    return ""
  elseif &modified
    return "+"
  elseif &modifiable
    return ""
  else
    return "-"
  endif
endfunction

function! LightlineReadonly()
  if &filetype !~ "help\|vimfiler\|gundo"
    return ""
  elseif &readonly
    return "\ue0a2"
  else
    return ""
  endif
endfunction

function! LightlineFilename()
  let fname = expand('%:t')
  return &ft == 'denite' ? denite#get_status_sources() . denite#get_status_path() : '' .
        \ ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineMode()
  return &ft == 'denite' ? 'denite' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ &ft == 'vimshell' ? 'VimShell' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! LightlineGitstatus()
  let branch = gina#component#repo#branch()
  if branch == ''
    return ''
  else
    let staged = gina#component#status#staged()
    let unstaged = gina#component#status#unstaged()
    let conflicted = gina#component#status#conflicted()
    let ahead = gina#component#traffic#ahead()
    let behind = gina#component#traffic#behind()
    return  "\ue725 " . branch .
          \ (winwidth(0) < 100 ? '' :
          \   (ahead      ? " \uf01b ".ahead      : '') .
          \   (behind     ? " \uf01a ".behind     : '') .
          \   (staged     ? " \uf055 ".staged     : '') .
          \   (unstaged   ? " \uf06a ".unstaged   : '') .
          \   (conflicted ? " \uf057 ".conflicted : '') )
  end
endfunction

function! LightlinePyenv()
  return &filetype =~ 'python' ? " \ue73c " . pyenv#info#preset('short')[1:] : ''
endfunction

