" options.vim --- setting vim/nvim options

" Vim files & directories {{{
" -----
set nobackup        " Don't create backup file
set undofile        " Create undo file
set swapfile        " Use swap file

" directory to store backup files
set backupdir=$VIM_CACHE_HOME/backup,~/tmp,/tmp
" directory to store swap files
set directory=$VIM_CACHE_HOME/swap,~/tmp,/tmp
" directory to store undo files
set undodir=$VIM_CACHE_HOME/undo,~/tmp,/tmp
" directory to store files for |:mkview|
set viewdir=$VIM_CACHE_HOME/view,~/tmp,/tmp

" viminfo/shada
"   ' - Maximum number of previously edited files marks
"   f - 1: store global marks (A-Z and 0-9), 0: nothing is stored
"   < - number of lines saved for each register
"   s - maximum size of an item contents in KiB
"   : - number of lines to save from the command line history
"   @ - number of lines to save from the input line history
"   / - number of lines to save from the search history
"   r - removable media, for which no marks will be stored
"       (can be used several times)
"   ! - global variables that start with an uppercase letter and
"       don't contain lowercase letters
"   h - disable 'hlsearch' highlighting when starting
"   % - the buffer list (only restored when starting Vim w/o file arguments)
"   c - convert the text using 'encoding'
"   n - name used for the ShaDa file (must be the last option)
if has('nvim')
  " stored to $XDG_DATA_HOME/nvim/shada/main.shada by default
  set shada='1000,<50,@100,s10,h
else
  " stored to ~/.viminfo by default
  set viminfo='1000,<20,@50,h,n$VIM_CACHE_HOME/viminfo
endif
" }}}

" Language {{{
" -----
" Prefer English help
set helplang=en,ja

" Set default language for spell check
" cjk - ignore spell check on Asian characters (China, Japan, Korea)
set nospell
set spelllang=en_us,cjk
" The words list file where words are added by `zw` and `zg` command
set spellfile=$VIM_DATA_HOME/spell/en.utf-8.add

" Use double in unicode emoji characters
set emoji
" Use single in ambiguous characters
set ambiwidth=single

" Prevent that the langmap option applies to characters that result from a
" mapping. If set (default), this may break plugins (but it's backward
" compatible).
if has('langmap') && exists('+langremap')
  set nolangremap
endif
" }}}

" Editting {{{
" -----
" Tabs, Indentations -> use editorconfig
" set textwidth=80    " Text width maximum chars before wrapping
" set expandtab       " Expand tabs to spaces.
" set tabstop=4       " The number of spaces a tab is
" set softtabstop=4   " While performing editing operations
" set shiftwidth=4    " Number of spaces to use in auto(indent)
set smarttab        " Tab insert blanks according to 'shiftwidth'
set autoindent      " Use same indenting on new lines
set smartindent     " Smart autoindenting on new lines
set copyindent      " copy the structure of the existing lines indent when
                    " autoindenting a new line
set preserveindent  " Use :retab to clean up whitespace
set shiftround      " Round indent to multiple of 'shiftwidth'

" Bases for numbers used by CTRL-A (increment) and CTRL-X (decrement) command.
set nrformats=alpha,hex,bin

" Allow virtual editing in Visual block mode.
set virtualedit=block

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

set showmatch       " Jump to matching bracket
set matchtime=1     " Tenths of a second to show the matching paren
set matchpairs+=<:> " Add HTML brackets to pair matching
" }}}

" Timing {{{
" -----
set timeout
set ttimeout
set timeoutlen=500  " Time out for a mapped sequence (ms)
set ttimeoutlen=50  " Time out for a key code sequence (ms)
set updatetime=1000 " Idle time to write swap and trigger CursorHold (ms)
" }}}

" Search {{{
" -----
set ignorecase      " Ignore cases in pattern
set smartcase       " Override 'ignorecase' if pattern contains upper cases.
set infercase       " Adjust case in insert completion mode
set hlsearch        " Highlight match results
set wrapscan        " Searches wrap around the end of the file

" Set external commands for grep
if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading\ -HS\ --line-number
  set grepformat=%f:%l:%c:%m
elseif executable('ag')
  set grepprg=ag\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow\ -C0
  set grepformat=%f:%l:%c:%m
elseif executable('pt')
  set grepprg=pt\ /nogroup\ /nocolor\ /smart-case\ /follow
  set grepformat=%f:%l:%m
endif
command! -nargs=* Grep grep <args>
" }}}

" Behavior {{{
" -----
set history=10000      " Amount of command line history
set hidden             " Hide buffers when abandoned instead of unload
set autoread           " Automatically read a file changed outside Vim
set nostartofline      " Cursor in same column for few commands
set linebreak          " Break long lines at 'breakat'
set showbreak=\        " String to put at the start of wrapped lines
set breakat=\ \	;:,!?  " Chars to break long lines
set splitbelow         " :split opens new window bottom of current window
set splitright         " :vsplit opens new window right of the current window
" Move to next/prev line on certain keys
"   char key        mode
"   b    <BS>       Normal and Visual
"   s    <Space>    Normal and Visual
"   h    "h"        Normal and Visual (not recommended)
"   l    "l"        Normal and Visual (not recommended)
"   <    <Left>     Normal and Visual
"   >    <Right>    Normal and Visual
"   ~    "~"        Normal
"   [    <Left>     Insert and Replace
"   ]    <Right>    Insert and Replace
set whichwrap+=h,l,<,>,[,],b,s~
if exists('+breakindent')
  set breakindent      " Every wrapped line will continue visually indented
  set wrap             " Wrap lines by default
else
  set nowrap           " Don't wrap lines by default
endif

" Behavior of switching between buffers
"  useopen - Jump to the first open window
"  usetab  - Jump to the first open window (consider windows in otehr tabs)
"  split   - split the current window before loading qf buffer (error)
"  vsplit  - similar to split, but split vertically
"  newtab  - similar to split, but open a new tab page
set switchbuf=useopen,usetab,vsplit

" Keywork completion
set showfulltag                " Show tag and tidy search in completion
set complete=.                 " No wins, buffs, tags, include scanning
set completeopt=menuone        " Show menu even for one item
set completeopt+=noselect      " Do not select a match in the menu
if has('patch-7.4.775')
  set completeopt+=noinsert
endif

" Diff mode
set diffopt=filler,iwhite      " Show fillers, ignore whitespace
if has('nvim') || has('patch-8.1.0360')
  " use internal diff library
  set diffopt+=internal,algorithm:histogram,indent-heuristic
endif

if exists('+inccommand')
  set inccommand=nosplit
endif

" What to save for views:
set viewoptions-=options       " Don't save local options and mappings
set viewoptions+=unix          " Use UNIX end-of-line format even when Windows
set viewoptions+=slash         " Replace \ in file names with /

" What to save in sessions:
set sessionoptions-=blank      " Don't save empty window
set sessionoptions-=buffers    " Don't save hidden and unloaded buffers
set sessionoptions-=globals    " Don't save global variables
set sessionoptions-=help       " Don't save help window
set sessionoptions-=options    " Don't save all options and mappings
set sessionoptions-=folds      " Don't save folds
" }}}

" Editor UI Appearances {{{
" -----
set title               " Display title on the window (e.g. terminal)
set nonumber            " Don't show line numbers
set noruler             " Disable default status ruler
set list                " Show hidden characters
set noshowmode          " Don't display mode in cmd window
set noshowcmd           " Don't show command in status line
set showtabline=1       " Always display the tabs line
set laststatus=2        " Always display a status line
set signcolumn=yes      " Draw sign column
set cursorline          " Highlight current line
set nocursorcolumn      " Do not highlight current column

set scrolloff=2         " Keep at least 2 lines above/below
set sidescrolloff=5     " Keep at least 5 lines left/right
set winwidth=30         " Minimum width for active window
set winminwidth=10      " Minimum width for inactive windows
set winheight=1         " Minimum height for active window
set pumheight=15        " Pop-up menu's line height
set helpheight=12       " Minimum help window height
set previewheight=8     " Completion preview height
set cmdheight=2         " Height of the command line
set cmdwinheight=5      " Command-line lines

set noequalalways       " Don't resize windows on split or close
set colorcolumn=80      " Highlight the 80th character limit
set display=lastline    " Don't omit line in @
" set report=0            " always report changes

if IsWindows()
  set listchars=tab:>-,trail:-,extends:>,precedes:<,nbsp:%,eol:$
else
  set listchars=tab:▸\ ,trail:-,extends:»,precedes:«,nbsp:%,eol:↲
endif

set shortmess=aoOTI     " Shorten messages and don't show intro
" Do not display completion messages
" Patch: https://groups.google.com/forum/#!topic/vim_dev/WeBBjkXE8H8
if has('patch-7.4.314')
  set shortmess+=c
endif
" Do not display message when editing files
if has('patch-7.4.1570')
  set shortmess+=F
endif

" Disable annoying bells
set noerrorbells
set novisualbell
set t_vb=
set belloff=all

" Characters to fill the statuslines and vertical separators
set fillchars=""

" For conceal
set conceallevel=2 concealcursor=nc

" Enable folding
set foldenable
set foldcolumn=1
set foldtext=FoldText()
" Kind of folding
"   manual - Folds are created manually.
"   indent - Lines with equal indent form a fold.
"   expr   - 'foldexpr' gives the fold level of a line.
"   marker - Markers are used to specify folds.
"   syntax - Syntax highlighting items specify folds.
"   diff   - Fold text that is not changed.
" set foldmethod=syntax

function! FoldText()
  " Get first non-blank line
  let fs = v:foldstart
  while getline(fs) =~? '^\s*$' | let fs = nextnonblank(fs + 1)
  endwhile
  if fs > v:foldend
    let line = getline(v:foldstart)
  else
    let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
  endif

  let w = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
  let foldSize = 1 + v:foldend - v:foldstart
  let foldSizeStr = ' ' . foldSize . ' lines '
  let foldLevelStr = repeat('+--', v:foldlevel)
  let lineCount = line('$')
  let foldPercentage = printf('[%.1f', (foldSize*1.0)/lineCount*100) . '%] '
  let expansionString = repeat('.', w - strwidth(foldSizeStr.line.foldLevelStr.foldPercentage))
  return line . expansionString . foldSizeStr . foldPercentage . foldLevelStr
endfunction
" }}}

" Wildmenu: enhanced command line completion {{{
" -----
if has('nvim')
  " Display candidates by popup menu (requires NeoVim 0.4.x or later)
  set wildmenu
  set wildmode=full
  set wildoptions=pum,tagfile
else
  " Display candidates by list
  set nowildmenu
  set wildmode=list:longest,full
  set wildoptions=tagfile
endif

" Ignore compiled files
set wildignore&
set wildignore=.git,.hg,.svn
set wildignore+=*.jpg,*.jpeg,*.bmp,*.gif,*.png
set wildignore+=*.o,*.obj,*.exe,*.dll,*.dylib,*.manifest,*.so,*.out,*.class
set wildignore+=*.swp,*.swo,*.swn
set wildignore+=*.DS_Store
" }}}

"----------------------------------------------------------------------------
" vim: foldmethod=marker
