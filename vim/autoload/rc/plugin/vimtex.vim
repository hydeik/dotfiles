function! rc#plugin#vimtex#hook_source() abort
  let g:vimtex_quickfix_open_on_warning = 0
  let g:vimtex_index_split_pos = 'below'
  let g:vimtex_fold_enabled = 1
  let g:vimtex_toc_fold = 1
  let g:vimtex_toc_hotkeys = {'enabled' : 1}
  let g:vimtex_format_enabled = 1
  let g:vimtex_view_method = 'zathura'
  let g:vimtex_imaps_leader = '\|'
  let g:vimtex_complete_img_use_tail = 1
  let g:vimtex_complete_close_braces = 1
  let g:vimtex_view_automatic = 0

  if has('nvim')
    let g:vimtex_compiler_progname = $PYENV_ROOT . '/versions/neovim3/bin/nvr'
  endif

  " Compile method (latexmk/latexrun/arara)
  let g:vimtex_compiler_method = 'latexmk'
  let g:vimtex_compiler_latex = {
        \ 'background' : 1,
        \ 'build_dir'  : '',
        \ 'callback'   : 1,
        \ 'continuous' : 1,
        \ 'options'    : [
        \   '-pdf',
        \   '-verbose',
        \   '-file-line-error',
        \   '-synctex',
        \   '-interaction=nonstopmode',
        \   ]
        \ }

  " PDF viwer
  if IsWindows()
    set isfname-={,}
    let g:vimtex_view_general_viewer = 'SumatraPDF'
    let g:vimtex_view_general_options
          \ = '-reuse-instance -forward-search @tex @line @pdf'
    let g:vimtex_view_general_options_latexmk = '-reuse-instance'
  elseif IsMac()
    let g:vimtex_view_method = 'skim'
  else " is linux
    let g:vimtex_view_method = 'zathura'
    let g:vimtex_view_forward_search_on_start = 0
  endif

  " Auto-completion with deoplete
  if !exists('g:deoplete#omni#input_patterns')
    let g:deoplete#omni#input_patterns = {}
  endif
  let g:deoplete#omni#input_patterns.tex = g:vimtex#re#deoplete
endfunction
