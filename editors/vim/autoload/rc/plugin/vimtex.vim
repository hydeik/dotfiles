function! rc#plugin#vimtex#hook_source() abort
  " Do not open quickfix window automatically only for warnings
  let g:vimtex_quickfix_open_on_warning = 0
  let g:vimtex_index_split_pos = 'below'
  " Fold documents according to LaTeX structure
  let g:vimtex_fold_enabled = 1
  " Fold TOC entries
  let g:vimtex_toc_fold = 1
  let g:vimtex_toc_hotkeys = {'enabled' : 1}
  " Use custom formatexpr provided by vimtex. If this is enabled,
  " comments and end of lines will not be joined with the `gq` command.
  let g:vimtex_format_enabled = 1

  let g:vimtex_imaps_leader = '\|'
  " Complete only the tail part of file names when triggered by
  " '\includegraphics{' command.
  let g:vimtex_complete_img_use_tail = 1
  " Append a closing brace after a label or a citation has been completed.
  let g:vimtex_complete_close_braces = 1
  " Don't open viewer manually (type <localleader>lv to launch viewer)
  let g:vimtex_view_automatic = 0

  if has('nvim')
    " Use neovim-remote (nvr) to prevent vimtex to lanch a nested vim process
    let g:vimtex_compiler_progname = $PYENV_ROOT . '/versions/neovim3/bin/nvr'
  endif

  " LaTeX compiler information (latexmk/latexrun/arara)
  let g:vimtex_compiler_method = 'latexmk'
  let g:vimtex_compiler_latexmk = {
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
