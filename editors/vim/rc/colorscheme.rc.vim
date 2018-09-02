" colorscheme.vim --- setup colorscheme on vim/nvim and costomize lightline

" Enable true color if supported
if !has('gui_running')
  "
  " TODO: We should check if the terminal emulater has truecolor supports, but
  " there is no reliable ways to do that. Some terminal emulater provides
  " $COLORTERM environment variable set to 'truecolor' or '24bit' so we also
  " checkt this variable.
  "
  if has('termguicolors') && ($COLORTERM ==# 'truecolor' || $COLORTERM ==# '24bit')
    " Enable true color in Vim on tmux (not necessary for NeoVim)
    if !has('nvim')
      let &t_8f = "\e[38;2;%lu;%lu;%lum"
      let &t_8b = "\e[48;2;%lu;%lu;%lum"
    endif
    set termguicolors
  endif
endif

" --- Font in GUI Vim
if has('gui_running')
  set guifont=Knack\ Nerd\ Font:h14
endif

" --- Colorscheme
set background=dark
let g:one_allow_italics = 1
colorscheme one

" let g:oceanic_next_bold = 1
" let g:oceanic_next_italic = 1
" colorscheme OceanicNext

highlight Normal     ctermbg=NONE guibg=NONE
highlight LineNr     ctermbg=NONE guibg=NONE
highlight SignColumn ctermbg=NONE guibg=NONE

" " --- Powerline (does not support NeoVim)
" python3 from powerline.vim import setup as powerline_setup
" python3 powerline_setup()
" python3 del powerline_setup

" --- Customize status line with lightline
let g:lightline = {
      \ 'colorscheme': 'one',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitstatus', 'filename' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype' ],
      \              [ 'pyenv' ] ],
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
  if &filetype =~? 'help\|vimfiler\|gundo'
    return ''
  elseif &modified
    return '+'
  elseif &modifiable
    return ''
  else
    return '-'
  endif
endfunction

function! LightlineReadonly()
  if &filetype !~? 'help\|vimfiler\|gundo'
    return ''
  elseif &readonly
    return "\ue0a2"
  else
    return ''
  endif
endfunction

function! LightlineFilename()
  let fname = expand('%:t')
  return &filetype ==? 'denite' ? denite#get_status_sources() . denite#get_status_path() : '' .
        \ ('' !=? LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ ('' !=? fname ? fname : '[No Name]') .
        \ ('' !=? LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=? '' ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 70 ? (&fileencoding !=? '' ? &fileencoding : &encoding) : ''
endfunction

function! LightlineMode()
  return  &filetype ==? 'denite' ? 'denite' :
        \ &filetype ==? 'vimfiler' ? 'VimFiler' :
        \ &filetype ==? 'vimshell' ? 'VimShell' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! LightlineGitstatus()
  let branch = gina#component#repo#branch()
  if branch ==# ''
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
  return &filetype =~? 'python' ? " \ue73c " . pyenv#info#preset('short')[1:] : ''
endfunction

