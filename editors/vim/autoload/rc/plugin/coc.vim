" List of coc-extensions to be instalBufEnterled
let s:coc_extension_list = [
      \ 'coc-css',
      \ 'coc-emmet',
      \ 'coc-emoji',
      \ 'coc-eslint',
      \ 'coc-html',
      \ 'coc-json',
      \ 'coc-neosnippet',
      \ 'coc-prettier',
      \ 'coc-pyls',
      \ 'coc-rls',
      \ 'coc-tsserver',
      \ 'coc-vetur',
      \ 'coc-word',
      \ 'coc-yaml'
      \ ]

function! s:coc_check_extensions() abort
  " Get list of installed extensions
  if !coc#rpc#ready() | return [] | endif
  let list = map(CocAction('extensionStats'), 'v:val["id"]')
  return filter(get(s:, 'coc_extension_list', []), 'index(list, v:val) < 0')
endfunction

" Utility funcitons for key mapping
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Hook functions called from dein
function! rc#plugin#coc#hook_add() abort
endfunction

function! rc#plugin#coc#hook_source() abort
  " Don't open quickfix window when changed by coc
  let g:coc_auto_open = 0

  " Use <TAB> for trigger completion with characters ahead and navigate.
  inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" : coc#refresh()
  " Use <S-TAB> for completion back
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  " Use <c-space> for trigger completion.
  inoremap <silent><expr> <C-Space> coc#refresh()

  " Use <CR> for confirm completion.
  "   `<C-g>u` means break undo chain at current position.
  "    Coc only does snippet and additional edit on confirm.
  inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

  " Use `[c` and `]c` for navigate diagnostics
  nmap <silent> [c <Plug>(coc-diagnostic-prev)
  nmap <silent> ]c <Plug>(coc-diagnostic-next)

  " Use K for show documentation in preview window
  nnoremap <silent> K :<C-u>call <SID>show_documentation()<CR>

  " Remap keys for gotos
  nmap <silent> gd <Plug>(coc-definition)
  " nmap <silent> gy <Plug>(coc-type-definition)
  " nmap <silent> gi <Plug>(coc-implementation)
  " nmap <silent> gr <Plug>(coc-references)

  " Key mappings: use <LocalLeader> as a prefix key
  " keys for gotos
  nmap     <silent><LocalLeader>d  <Plug>(coc-definition)
  nmap     <silent><LocalLeader>i  <Plug>(coc-implementation)
  nmap     <silent><LocalLeader>r  <Plug>(coc-reference)
  nmap     <silent><LocalLeader>t  <Plug>(coc-type-definition)

  " Rename symbol under the cursor to a new word
  nmap     <silent><LocalLeader>R  <Plug>(coc-rename)
  " Show documentation (help)
  nnoremap <silent><LocalLeader>h  :<C-u>call <SID>show_documentation()<CR>

  " format selected region
  vmap <LocalLeader>=  <Plug>(coc-format-selected)
  nmap <LocalLeader>=  <Plug>(coc-format-selected)

  " do codeAction of selected region, ex: `<LocalLeader>aap` for
  " current paragraph
  vmap <LocalLeader>a  <Plug>(coc-codeaction-selected)
  nmap <LocalLeader>a  <Plug>(coc-codeaction-selected)

  " do codeAction for current line
  nmap <LocalLeader>ca  <Plug>(coc-codeaction)
  " do codeLensAction for current line
  nmap <LocalLeader>cl  <Plug>(coc-codeaction)
  " Fix autofix problem of current line
  nmap <LocalLeader>F  <Plug>(coc-fix-current)

  " --- Shortcuts for denite interface (use [Denite]c as prefix)
  " Show extension list
  nnoremap <silent> [Denite]ce  :<c-u>Denite coc-extension<CR>
  " Show symbols of current buffer
  nnoremap <silent> [Denite]co  :<C-u>Denite coc-symbols<CR>
  " Search symbols of current workspace
  nnoremap <silent> [Denite]cw  :<C-u>Denite coc-workspace<CR>
  " Show diagnostics of current workspace
  nnoremap <silent> [Denite]ca  :<C-u>Denite coc-diagnostic<CR>
  " Show available commands
  nnoremap <silent> [Denite]cc  :<C-u>Denite coc-command<CR>
  " Show available services
  nnoremap <silent> [Denite]cs  :<C-u>Denite coc-service<CR>
  " Show links of current buffer
  nnoremap <silent> [Denite]cl  :<C-u>Denite coc-link<CR>
endfunction

function! rc#plugin#coc#hook_post_source() abort
  " Use `:Format` for format current buffer
  command! -nargs=0 Format :call CocAction('format')
  " Use `:Fold` for fold current buffer
  command! -nargs=? Fold   :call CocAction('fold', <f-args>)

  let missing = s:coc_check_extensions()
  if !empty(missing)
    call coc#util#install_extension(join(missing))
  endif
endfunction

function! rc#plugin#coc#hook_post_update() abort
  call coc#util#install()
  call coc#util#update()
endfunction

