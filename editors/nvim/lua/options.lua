--- ~/.config/nvim/lua/core/options.lua
--- Set global options
local globals = require "globals"
local opt = vim.opt

-- List of character encodings considered when starting to edit an existing file
opt.fileencodings = {
  "ucs-bom",
  "utf-8",
  "euc-jp",
  "iso-2022-jp-3",
  "cp932",
  "utf-16",
  "utf-16le",
  "cp1250",
}

-- IME setting
if vim.fn.has "multi_byte_ime" == 1 then
  opt.iminsert = 0
  opt.imsearch = 0
end

--[[
  Enable true color if supported.

  TODO: We should check if the terminal emulater has truecolor supports, but
  there is no reliable ways to do that. Some terminal emulater provides
  $COLORTERM environment variable set to 'truecolor' or '24bit' so we may
  checkt this variable.
--]]
if vim.fn.has "termguicolors" == 1 and vim.fn.has "gui_running" == 0 then
  vim.o.termguicolors = true
end

--- Vim files & directories {{{
opt.backup = false
opt.writebackup = false
opt.undofile = true
opt.swapfile = false

-- Directories to store backup, swap, view, and shada files
opt.backupdir = globals.nvim_dir.backup
opt.directory = globals.nvim_dir.swap
opt.undodir = globals.nvim_dir.undo
opt.viewdir = globals.nvim_dir.view

-- Customize shada files entries.
-- Shada files are stored to $XDG_DATA_HOME/nvim/shada/main.shada by default
opt.shada = { "'200", "<50", "@100", "s10", "h" }
--- }}}

--- Language {{{
-- prefer english help
opt.helplang = { "en", "ja" }
-- The words list file where words are added by `zw` and `zg` command
opt.spellfile = globals.nvim_dir.data .. "/spell/en.utf-8.add"
-- spell check (ignore on check on Asian characters (China, Japan, Korea))
opt.spelllang = { "en_us", "cjk" }
-- opt.spell = false

-- -- Use single in ambiguous characters
-- vim.o.ambiwidth = "single"

--- }}}

--- Editting {{{
opt.smartindent = true
opt.copyindent = true
opt.preserveindent = true
opt.shiftround = true
-- Bases for numbers used by CTRL-A (increment) and CTRL-X (decrement) command.
opt.nrformats = { "alpha", "hex", "bin" }
-- Allow virtual editing in Visual block mode.
opt.virtualedit = { "block" }
-- Allow backspacing over everything in insert mode
opt.backspace = { "indent", "eol", "start" }
-- Use system clipboard
if globals.is_windows or vim.fn.has "clipboard" then
  opt.clipboard = { "unnamed" }
else
  opt.clipboard = { "unnamedplus" }
end

opt.showmatch = true -- Jump to matching bracket
opt.matchtime = 1 -- Tenths of a second to show the matching paren
opt.matchpairs = "(:),{:},[:],<:>"
--- }}}

--- Timing {{{
opt.timeoutlen = 500 -- Time out for a mapped sequence (ms)
opt.ttimeoutlen = 50 -- Time out for a key code sequence (ms)
opt.updatetime = 1000 -- Idle time to write swap and trigger CursorHold (ms)
--- }}}

--- Search {{{
opt.ignorecase = true -- Ignore cases in pattern
opt.smartcase = true -- Override 'ignorecase' if pattern contains upper cases.
opt.infercase = true -- Adjust case in insert completion mode
--- }}}

--- Behavior {{{
opt.history = 10000 -- Amount of command line history
opt.hidden = true -- Hide buffers when abandoned instead of unload
opt.linebreak = true -- Break long lines at 'breakat'
opt.showbreak = [[\]] -- String to put at the start of wrapped lines
opt.breakat = [[\ \	;:,!?]] -- Chars to break long lines
opt.splitbelow = true -- :split opens new window bottom of current window
opt.splitright = true -- :vsplit opens new window right of the current window
-- Move to next/prev line on certain keys
opt.whichwrap = "b,s,h,l,<,>,[,],b,s~"
if vim.fn.exists "+breakindent" then
  opt.breakindent = true -- Every wrapped line will continue visually indented
  opt.wrap = true -- Wrap lines by default
else
  opt.wrap = false -- Don't wrap lines otherwise
end

-- Keywork completion
opt.showfulltag = true -- Show tag and tidy search in completion
opt.complete = "." -- No wins, buffs, tags, include scanning
-- opt.completeopt = "menuone,noselect"

-- Diff mode
opt.diffopt = { "filler", "iwhite", "internal", "algorithm:histogram", "indent-heuristic" }

-- What to save for views:
opt.viewoptions = { "folds", "cursor", "curdir", "slash", "unix" }

-- What to save in sessions:
opt.sessionoptions = { "curdir", "tabpages", "winsize" }
--- }}}

-- Editor UI Appearances {{{
opt.title = true -- Display title on the window (e.g. terminal)
opt.number = false -- Don't show line numbers
opt.ruler = false -- Disable default status ruler
opt.list = true -- Show hidden characters
opt.showmode = false -- Don't display mode in cmd window
opt.showcmd = false -- Don't show command in status line
opt.signcolumn = "yes" -- Always draw sign column
opt.cursorline = true -- Highlight current line

opt.scrolloff = 2 -- Keep at least 2 lines above/below
opt.sidescrolloff = 5 -- Keep at least 5 lines left/right
opt.winwidth = 30 -- Minimum width for active window
opt.winminwidth = 10 -- Minimum width for inactive windows
opt.pumheight = 15 -- Pop-up menu's line height
opt.helpheight = 12 -- Minimum help window height
opt.cmdheight = 2 -- Height of the command line
opt.cmdwinheight = 5 -- Command-line lines

opt.equalalways = false -- Don't resize windows on split or close
opt.colorcolumn = "+1" -- Highlight 'textwidth+1'-th column
opt.display = { "lastline", "uhex" }

opt.listchars = {
  tab = "▸ ",
  trail = "-",
  extends = "»",
  precedes = "«",
  nbsp = "%",
  eol = "↲",
}
opt.shortmess = "aoOTIcF" -- Shorten messages and don't show intro

-- Disable annoying bells
opt.errorbells = false
opt.visualbell = false
opt.belloff = "all"

-- Characters to fill the statuslines and vertical separators
opt.fillchars = ""

-- Enable folding
opt.foldenable = true
opt.foldcolumn = "0"

--- }}}

--- Wildmenu: enhanced command line completion {{{

-- Display candidates by popup menu (requires NeoVim 0.4.x or later)
opt.wildoptions = { "pum", "tagfile" }
opt.pumblend = 10

-- Ignore compiled files
opt.wildignore = {
  ".git",
  ".hg",
  ".svn",
  "*.jpg",
  "*.JPG",
  "*.jpeg",
  "*.JPEG",
  "*.png",
  "*.PNG",
  "*.bmp",
  "*.gif",
  "*.o",
  "*.obj",
  "*.exe",
  "*.dll",
  "*.dylib",
  "*.manifest",
  "*.so",
  "*.out",
  "*.class",
  "__pycache__",
  "*.pyc",
  "*pycache*",
  "*.swp",
  "*.swo",
  "*.swn",
  "*.DS_Store",
  "*.ttf",
  "*.otf",
}
--- }}}