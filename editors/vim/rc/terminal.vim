"-----------------------------------------------------------------------------
" ~/.config/nvim/rc/terminal.vim
"   This file is loaded starting up Vim on terminal (not loaded on GUI Vim).

" Enable true color if supported {{{
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
" }}}

" Enhance performance of scroll in vsplit mode via DECSLRM {{{
" -----
" NOTE: NeoVim (libvterm) already supports it but Vim doesn't.
" Ref: https://qiita.com/kefir_/items/c725731d33de4d8fb096
" Ref: https://github.com/neovim/libvterm/commit/04781d37ce5af3f580376dc721bd3b89c434966b
if !has('nvim') && has('vertsplit')
  function! s:enable_vsplit_mode()
    " enable origin mode and left/right margins
    let &t_CS = "y"
    let &t_ti = &t_ti . "\e[?6;69h"
    let &t_te = "\e[?6;69l\e[999H" . &t_te
    let &t_CV = "\e[%i%p1%d;%p2%ds"
    call writefile([ "\e[?6;69h" ], "/dev/tty", "a")
  endfunction

  " Old vim does not ignore CPR
  map <special> <Esc>[3;9R <Nop>

  " New vim can't handle CPR with direct mapping
  " map <expr> ^[[3;3R <SID>enable_vsplit_mode()
  set t_F9=^[[3;3R
  map <expr> <t_F9> <SID>enable_vsplit_mode()
  let &t_RV .= "\e[?6;69h\e[1;3s\e[3;9H\e[6n\e[0;0s\e[?6;69l"
endif
" }}}

"-----------------------------------------------------------------------------
" vim: foldmethod=marker
