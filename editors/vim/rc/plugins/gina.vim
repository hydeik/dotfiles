" Set default options for commands {{{
call gina#custom#command#option(
      \ 'commit',
      \ '-v|--verbose'
      \ )

call gina#custom#command#option(
      \ '\%(commit\|tag\)',
      \ '--restore'
      \ )

call gina#custom#command#option(
      \ '\%(status\|commit\)',
      \ '-u|--untracked-files'
      \ )

call gina#custom#command#option(
      \ '/\%(status\|changes\)',
      \ '--ignore-submodules'
      \ )

call gina#custom#command#option(
      \ 'status',
      \ '-b|--branch'
      \ )

call gina#custom#command#option(
      \ 'status',
      \ '-s|--short'
      \ )

call gina#custom#command#option(
      \ 'show',
      \ '--show-signature'
      \ )

call gina#custom#command#option(
      \ 'log',
      \ '--group', 'log-viwer'
      \ )

call gina#custom#command#option(
      \ 'reflog',
      \ '--group', 'reflog-viwer'
      \ )
" }}}

" Custom aliases {{{
call gina#custom#action#alias(
      \ 'branch', 'track',
      \ 'checkout:track'
      \ )

call gina#custom#action#alias(
      \ 'branch', 'merge',
      \ 'commit:merge'
      \ )

call gina#custom#action#alias(
      \ 'branch', 'rebase',
      \ 'commit:rebase'
      \ )

call gina#custom#action#alias(
      \ '/\%(blame\|log\|reflog\)',
      \ 'preview',
      \ 'topleft show:commit:preview',
      \)
" }}}

" Custom key mappings {{{
" call gina#custom#mapping#nmap(
"      \ '/\%(status\|branch\|blame\|changes\|commit\|log\|reflog\|tag\)', 'q',
"      \ ':<C-u>close<CR>',
"      \ {'noremap': 1, 'silent': 1}
"      \ )

call gina#custom#mapping#nmap(
      \ 'branch', 'g<CR>',
      \ '<Plug>(gina-commit-checkout-track)'
      \)

call gina#custom#mapping#nmap(
      \ 'branch', 'D',
      \ ':call gina#action#call(''branch:delete'')<CR>',
      \ {'noremap': 1, 'silent': 1}
      \ )

call gina#custom#mapping#nmap(
      \ 'branch', 'N',
      \ ':call gina#action#call(''branch:new'')<CR>',
      \ {'noremap': 1, 'silent': 1}
      \ )

call gina#custom#mapping#nmap(
      \ 'branch', 'm',
      \ ':call gina#action#call(''branch:move'')<CR>',
      \ {'noremap': 1, 'silent': 1}
      \ )

call gina#custom#mapping#nmap(
      \ 'branch', 'r',
      \ ':call gina#action#call(''branch:refresh'')<CR>',
      \ {'noremap': 1, 'silent': 1}
      \ )

call gina#custom#mapping#nmap(
      \ 'status', '<C-c><C-c>', ':<C-u>Gina commit<CR>',
      \ {'noremap': 1, 'silent': 1}
      \ )

call gina#custom#mapping#nmap(
      \ '/\%(blame\|log\|reflog\)', 'p',
      \ ':<C-u>call gina#action#call(''preview'')<CR>',
      \ {'noremap': 1, 'silent': 1}
      \ )

call gina#custom#mapping#nmap(
      \ '/\%(blame\|log\|reflog\)', 'c',
      \ ':<C-u>call gina#action#call(''changes'')<CR>',
      \ {'noremap': 1, 'silent': 1}
      \)
" }}}

" Options {{{
call gina#custom#execute(
      \ '/\%(status\|blame\|branch\|ls\|grep\|changes\|tag\)',
      \ 'setlocal winfixheight',
      \ )

call gina#custom#execute(
      \ '/\%(ls\|log\|reflog\|grep\)',
      \ 'setlocal noautoread',
      \)

call gina#custom#execute(
      \ '/\%(status\|branch\|ls\|log\|reflog\|grep\)',
      \ 'setlocal cursorline',
      \)

" }}}
