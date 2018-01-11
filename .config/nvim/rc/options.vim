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

" ----- Tab
set smarttab
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

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

" ----- Edit
" Behavior of <BS>, <DEL>, CTRL-W, CTRL-U in insert mode
"   - indent: allow backspacing over autoindent
"   - eol   : allow backspacing over line breakds (join lines)
"   - start : allow backspacing over the start of insert;
"             CTRL-W and CTRL-U stop once at the start of insert.
set backspace=indent,eol,start
" Auto indent
set autoindent
" Round indent ('>' and '<' commands) to multiple of 'shiftwidth'
set shiftround
" When a bracket is inserted, briefly jump to the matching one.
set showmatch
" Time to show the matching paren, when 'showmatch' is set. (0.1 second)
set matchtime=2
" Set additional format options for Japanese text
"   m - Also break at a multi-byte character above 255.  This is useful for
"       Asian text where every character is a word on its own.
"   M - When joining lines, don't insert a space before or after a multi-byte
"       character.  Overrules the 'B' flag.
set formatoptions+=mM
" Allow virtual editing in Visual block mode.
set virtualedit=block
" Wait 500 msec for a mapped sequence to complete
set timeout timeoutlen=500
" Wait 50 msec for a key code
set ttimeout ttimeoutlen=50
" Enable Vim to use system clipboard
set clipboard&   " <- set to default
set clipboard^=unnamed,unnamedplus

" ----- Display
" Print line number in front of each line
set number
" Show the line and column number of the cursor position
set ruler
" 
set ambiwidth=double
" Display unprinted characters. 
set list
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲
" Always display status line
set laststatus=2
" Number of screen lines to use for the command-line.
set cmdheight=2
" Show (partial) command in the last line of the screen.
set showcmd
" Display title on the window (e.g. terminal)
set title
" Highlight the screen line of the cursor
set cursorline
" Max number of items in popup menu
set pumheight=15

