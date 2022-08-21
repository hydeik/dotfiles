--- ~/.config/nvim/lua/rc/core/settings.lua
--
--- Change Neovim's default behavior:
---   1. Use lua based filetype detection
---   2. Disable unused providers for remote plugins
---   3. Disable some built-in Neovim plugins
---   4. Set global options
---

local fs = require("rc.utils.fs")
local opt = vim.opt

-- Providers (set python3 interpreter, disable nodejs, perl, ruby) {{{1
-- vim.g.python3_host_prog = vim.env.HOME .. "/.asdf/shims/python3"
vim.g.python3_host_prog = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
-- }}}1

-- Disable some unused built-in Neovim plugins {{{1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_man = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.netrw_nogx = 1
vim.g.loaded_netrwFileHandlers = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
-- }}}1


--- Overwrite nvim default global options {{{1

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

-- Vim files & directories {{{2
opt.backup = false
opt.writebackup = false
opt.undofile = true
opt.swapfile = false

-- Directories to store backup, swap, view, and shada files
-- backupdir: [default ".,$XDG_STATE_HOME/nvim/backup/"]
opt.backupdir = fs.join(vim.fn.stdpath("state"), "backup")
-- directory: [default: $XDG_STATE_HOME/nvim/swap/]
-- undodir: [default: $XDG_STATE_HOME/nvim/undo/]
-- directory: [default: $XDG_STATE_HOME/nvim/swap/]
-- viewdir: [default: $XDG_STATE_HOME/nvim/view/]

-- Customize shada files entries.
-- Shada files are stored to $XDG_STATE_HOME/nvim/shada/main.shada by default
opt.shada = { "'200", "<50", "@100", "s10", "h" }
-- }}}2

-- Language {{{2
-- prefer english help
opt.helplang = { "en", "ja" }
-- The words list file where words are added by `zw` and `zg` command
opt.spellfile = fs.join(vim.fn.stdpath("data"), "spell", "en.utf-8.add")
-- spell check (ignore on check on Asian characters (China, Japan, Korea))
opt.spelllang = { "en_us", "cjk" }
-- opt.spell = false

-- -- Use single in ambiguous characters
-- vim.o.ambiwidth = "single"

-- }}}2

-- Editting {{{2
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
opt.clipboard:append("unnamed")
opt.clipboard:append("unnamedplus")
local uname = vim.loop.os_uname()
if (uname.sysname == "Windows_NT") or not (string.find(uname.release, "microsoft") == nil) then
  vim.g.clipboard = {
    name = "win32yank",
    copy = {
      ["+"] = "win32yank.exe -i --crlf",
      ["*"] = "win32yank.exe -i --crlf",
    },
    paste = {
      ["+"] = "win32yank.exe -o --lf",
      ["*"] = "win32yank.exe -o --lf",
    },
    cache_enabled = 0,
  }
end

opt.showmatch = true -- Jump to matching bracket
opt.matchtime = 1 -- Tenths of a second to show the matching paren
opt.matchpairs:append { "<:>", "（:）", "「:」", "【:】", "［:］", "｛:｝", "＜:＞" }
-- }}}2

-- Timing {{{2
opt.timeoutlen = 500 -- Time out for a mapped sequence (ms)
opt.ttimeoutlen = 50 -- Time out for a key code sequence (ms)
opt.updatetime = 1000 -- Idle time to write swap and trigger CursorHold (ms)
-- }}}2

-- Search {{{2
opt.ignorecase = true -- Ignore cases in pattern
opt.smartcase = true -- Override 'ignorecase' if pattern contains upper cases.
opt.infercase = true -- Adjust case in insert completion mode
-- }}}2

-- Behavior {{{2
opt.hidden = true -- Hide buffers when abandoned instead of unload
opt.linebreak = true -- Break long lines at 'breakat'
opt.showbreak = [[\]] -- String to put at the start of wrapped lines
opt.breakat = [[\ \	;:,!?]] -- Chars to break long lines
opt.splitbelow = true -- :split opens new window bottom of current window
opt.splitright = true -- :vsplit opens new window right of the current window
-- Move to next/prev line on certain keys
opt.whichwrap:append {
  b = true,
  s = true,
  h = true,
  l = true,
  ["<"] = true,
  [">"] = true,
  ["~"] = true,
  ["["] = true,
  ["]"] = true,
}

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

-- }}}2

-- Editor UI Appearances {{{2
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

opt.listchars = {
  tab = "▸ ",
  trail = "-",
  extends = "»",
  precedes = "«",
  nbsp = "%",
  eol = "↲",
}
-- opt.shortmess = "aoOTIcF" -- Shorten messages and don't show intro
opt.shortmess = {
  a = true,
  o = true,
  O = true,
  T = true,
  I = true,
  c = true,
  F = true,
}

-- Disable annoying bells
opt.errorbells = false
opt.visualbell = false
opt.belloff = "all"

-- Characters to fill the statuslines and vertical separators
opt.fillchars = {
  horiz     = '━',
  horizup   = '┻',
  horizdown = '┳',
  vert      = '┃',
  vertleft  = '┫',
  vertright = '┣',
  verthoriz = '╋',
}

-- Make only the last window have a status line
opt.laststatus = 3

-- Enable folding
opt.foldenable = true
opt.foldcolumn = "0"

--- }}}2

--- Wildmenu: enhanced command line completion {{{2

-- Display candidates by popup menu (requires NeoVim 0.4.x or later)
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
-- }}}2
-- }}}1

