function! s:defx_my_settings() abort
  " --- Define mappings ---
  nnoremap <silent><buffer><expr> <CR>    defx#do_action('open')
  nnoremap <silent><buffer><expr> <Space> defx#do_action('toggle_select') . 'j'
  nnoremap <silent><buffer><expr> *       defx#do_action('toggle_select_all')
  nnoremap <silent><buffer><expr> ~       defx#do_action('cd')
  nnoremap <silent><buffer><expr> h       defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> j       line('.') == line('$') ? 'gg' : 'j'
  nnoremap <silent><buffer><expr> k       line('.') == 1 ? 'G' : 'k'
  nnoremap <silent><buffer><expr> l       defx#do_action('open')
  nnoremap <silent><buffer><expr> m       defx#do_action('rename')
  nnoremap <silent><buffer><expr> r       defx#do_action('rename')
  " Note: 'remove_trash' action requires the Send2Trash python package
  nnoremap <silent><buffer><expr> x       defx#do_action('remove_trash')
  nnoremap <silent><buffer><expr> X       defx#do_action('remove')
  nnoremap <silent><buffer><expr> V       defx#do_action('open', 'vsplit')
  nnoremap <silent><buffer><expr> P       defx#do_action('open', 'pedit')
  nnoremap <silent><buffer><expr> D       defx#do_action('new_directory')
  nnoremap <silent><buffer><expr> N       defx#do_action('new_file')
  nnoremap <silent><buffer><expr> q       defx#do_action('quit')
  nnoremap <silent><buffer><expr> <C-l>   defx#do_action('redraw')
  nnoremap <silent><buffer><expr> <C-g>   defx#do_action('print')
endfunction

function! rc#plugin#defx#hook_source() abort
  autocmd MyVimrc FileType defx call s:defx_my_settings()
endfunction
