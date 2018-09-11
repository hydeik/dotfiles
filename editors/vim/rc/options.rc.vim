" options.vim --- setting vim/nvim options

" ----- Search
" Ignore cases in pattern
set ignorecase
" Override 'ignorecase' if pattern contains upper cases.
set smartcase
" Searches wrap around the end of the file
set wrapscan
" Highlights matches
set hlsearch
" Incremental search
set incsearch
" Program used to 'K' command
set keywordprg=:help

" ----- Tabs, Indentations -> use editorconfig
" set smarttab
" set expandtab
" set tabstop=4
" set shiftwidth=4
" set softtabstop=4

" ----- Files
set confirm
" Make a buffer becomes hidden when it is abandoned. This allows to switch
" buffer even if modified (unsaved) buffer is present.
set hidden
" When a file has been detected to have been changed outside of Vim and it has
" not been changed inside of Vim, automatically read it again.
set autoread
" Do not make a backup file before overwriting a file
set nobackup
" Do not make a swapfile
set noswapfile
" Number of lines to be checked as modeline
set modelines=5
" Persistent undo
if exists('persistet_undo')
  set undofile
  " Directory to store undo file (default: '$XDG_DATA_HOME/nvim/undo')
  " set undodir=
endif

" ----- Edit
" Behavior of <BS>, <DEL>, CTRL-W, CTRL-U in insert mode
"   - indent: allow backspacing over autoindent
"   - eol   : allow backspacing over line breakds (join lines)
"   - start : allow backspacing over the start of insert;
"             CTRL-W and CTRL-U stop once at the start of insert.
set backspace=indent,eol,start

" Use system clipboard
if (!has('nvim') || $DISPLAY != '') && has('clipboard')
  if has('unnamedplus')
    set clipboard& clipboard+=unnamedplus
  else
    set clipboard& clipboard+=unnamed
  endif
endif

" Auto indent
set autoindent
" Round indent ('>' and '<' commands) to multiple of 'shiftwidth'
set shiftround
" When a bracket is inserted, briefly jump to the matching one.
set showmatch
" Time to show the matching paren, when 'showmatch' is set. (0.1 second)
set matchtime=1
" Set additional format options for Japanese text
"   m - Also break at a multi-byte character above 255.  This is useful for
"       Asian text where every character is a word on its own.
"   M - When joining lines, don't insert a space before or after a multi-byte
"       character.  Overrules the 'B' flag.
set formatoptions+=mM
" Bases for numbers used by CTRL-A (increment) and CTRL-X (decrement) command.
set nrformats=alpha,hex,bin
" Allow virtual editing in Visual block mode.
set virtualedit=block
" Wait 500 msec for a mapped sequence to complete
set timeout timeoutlen=1000
" Wait 50 msec for a key code
set ttimeout ttimeoutlen=50

" Enable folding
set foldenable
set foldmethod=marker
" Show folding level
set foldcolumn=2
" set fillchars=vert:\|
set fillchars=""
set commentstring=%s

augroup foldmethod
  autocmd!
  autocmd BufRead,BufNewFile *.toml,*.zshrc setlocal commentstring=#%s
  autocmd BufRead,BufNewFile *.vim          setlocal commentstring=\"%s
  autocmd BufRead,BufNewFile *.html         setlocal commentstring=<!--%s-->
  autocmd BufRead,BufNewFile *.md,*.mkd     setlocal commentstring=<!--%s-->
augroup END

" Fast fold
autocmd MyVimrc TextChangedI,TextChanged *
      \ if &l:foldenable && &l:foldmethod !=# 'manual' |
      \   let b:foldmethod_save = &l:foldmethod |
      \   let &l:foldmethod = 'manual' |
      \ endif
autocmd MyVimrc BufWritePost *
      \ if &l:foldmethod ==# 'manual' && exists('b:foldmethod_save') |
      \   let &l:foldmethod = b:foldmethod_save |
      \   execute 'normal! zx' |
      \ endif

if exists('*FoldCCtext')
  " Use FoldCCtext
  set foldtext=FoldCCtext()
endif

" ----- Display
" Don't redraw while executing macros
set lazyredraw
" Show the line and column number of the cursor position
set ruler
" Display unprinted characters.
set list
" Display long text line properly
set display=lastline
" Always display status line
set laststatus=2
" Show (partial) command in the last line of the screen.
set showcmd
" Do not show current mode (insert, visutl, normal, etc.) -> set by lightline
set noshowmode
" Display title on the window (e.g. terminal)
set title
" " Highlight the screen line of the cursor
" set cursorline
" Max number of items in popup menu
set pumheight=10
" Set height of command-line. This is set to supress unwanted 'Press ENTER...'
" prompts.
set cmdheight=2
" Enhanced command line completion
set wildmenu
" Completion style in wildmenu mode
set wildmode=list:longest,full
" Ignore compiled files
set wildignore&
set wildignore=.git,.hg,.svn
set wildignore+=*.jpg,*.jpeg,*.bmp,*.gif,*.png
set wildignore+=*.o,*.obj,*.exe,*.dll,*.dylib,*.manifest,*.so,*.out,*.class
set wildignore+=*.swp,*.swo,*.swn
set wildignore+=*.DS_Store

" ----- Window
" Create a new window below the current window when :split is called
" set splitbelow
" Create a new window right side of the current window when :vsplit is called
set splitright
