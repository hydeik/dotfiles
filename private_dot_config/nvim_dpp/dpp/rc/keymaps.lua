--- ~/.config/nvim/lua/mapping.lua

--
-- -----------------------------------------------------------------------------
-- | Commands \ Modes | Normal | Insert | Command | Visual | Select | Operator |
-- |------------------|--------|--------|---------|--------|--------|----------|
-- | map  / noremap   |    @   |   -    |    -    |   @    |   @    |    @     |
-- | nmap / nnoremap  |    @   |   -    |    -    |   -    |   -    |    -     |
-- | vmap / vnoremap  |    -   |   -    |    -    |   @    |   @    |    -     |
-- | omap / onoremap  |    -   |   -    |    -    |   -    |   -    |    @     |
-- | xmap / xnoremap  |    -   |   -    |    -    |   @    |   -    |    -     |
-- | smap / snoremap  |    -   |   -    |    -    |   -    |   @    |    -     |
-- | map! / noremap!  |    -   |   @    |    @    |   -    |   -    |    -     |
-- | imap / inoremap  |    -   |   @    |    -    |   -    |   -    |    -     |
-- | cmap / cnoremap  |    -   |   -    |    @    |   -    |   -    |    -     |
-- -----------------------------------------------------------------------------
--

local utils = require "rc.utils"

--- Prefix keys {{{
vim.g.mapleader = ";"
vim.g.maplocalleader = "\\"
-- release keymappings for plugins
vim.keymap.set("n", "<Space>", "<Nop>")
vim.keymap.set("x", "<Space>", "<Nop>")
vim.keymap.set("n", ";", "<Nop>")
vim.keymap.set("x", ";", "<Nop>")
vim.keymap.set("n", ",", "<Nop>")
vim.keymap.set("x", ",", "<Nop>")
-- vim.keymap.set("n", "m", "<Nop>")
-- vim.keymap.set("x", "m", "<Nop>")
vim.keymap.set("n", "s", "<Nop>")
vim.keymap.set("x", "s", "<Nop>")

vim.keymap.del({ "n", "x", "o" }, "gc")
vim.keymap.del("n", "gcc")
--- }}}

--- Basic mappings {{{
-- Disable Ex-mode, remap to register macros
vim.keymap.set("n", "Q", "q")
vim.keymap.set("n", "gQ", "@q")

-- Disable dangerous/annoying default mappings
--   ZZ - Save current file and quit
--   ZQ - Quit without checking changes (:q!)
vim.keymap.set("n", "ZZ", "<Nop>")
vim.keymap.set("n", "ZQ", "<Nop>")

-- Useless command. M - to middle line of window
vim.keymap.set("n", "M", "m")

-- Y: yank text from cursor position to the EOL
-- -> Now this mapping is default. (https://github.com/neovim/neovim/pull/13268)
-- nnoremap { "Y", "y$" }

-- Emacs-like cursor move in insert/command mode
vim.keymap.set("i", "<C-a>", "<Home>")
vim.keymap.set("i", "<C-b>", "<Left>")
vim.keymap.set("i", "<C-d>", "<Del>")
vim.keymap.set("i", "<C-e>", "<End>")
vim.keymap.set("i", "<C-f>", "<Right>")
vim.keymap.set("i", "<C-k>", "<C-o>D")
-- Enable undo <C-w> and <C-u> in insert mode.
vim.keymap.set("i", "<C-w>", "<C-g>u<C-w>")
vim.keymap.set("i", "<C-u>", "<C-g>u<C-u>")

-- Command-line mode key mappings
-- <C-a>: move to head
vim.keymap.set("c", "<C-a>", "<Home>")
-- <C-b>: previous char
vim.keymap.set("c", "<C-b>", "<Left>")
-- <C-d>: delete char
vim.keymap.set("c", "<C-d>", "<Del>")
-- <C-e>: move to end
vim.keymap.set("c", "<C-e>", "<End>")
-- <C-f>: next char
vim.keymap.set("c", "<C-f>", "<Right>")
-- <C-n>: next history
vim.keymap.set("c", "<C-n>", "<Down>")
-- <C-p>: previous history
vim.keymap.set("c", "<C-p>", "<Up>")
-- <C-y>: paste
vim.keymap.set("c", "<C-y>", "<C-r>*")
-- <C-g>: exit
vim.keymap.set("c", "<C-g>", "<C-c>")
-- <C-k>: delete to the end
vim.keymap.set("c", "<C-k>", [[repeat("\<Del>", strchars(getcmdline()[getcmdpos() - 1:]))]], { expr = true })

-- Indent by > and <
vim.keymap.set("n", ">", ">>")
vim.keymap.set("n", "<", "<<")

-- Maintain visual mode after shifting > and <
vim.keymap.set("x", ">", ">gv")
vim.keymap.set("x", "<", "<gv")

-- Easy escape
vim.keymap.set("i", "jj", "<ESC>")
vim.keymap.set("i", "j ", "j")
vim.keymap.set("c", "j", [[getcmdline()[getcmdpos()-2] ==# 'j' ? "\<BS>\<C-c>" : 'j']], { expr = true })

-- Start new line from any cursor position
vim.keymap.set("i", "<S-Return>", "<C-o>o")

-- Change current word in a repeatable manner
vim.keymap.set("n", "cn", "*``cgn")
vim.keymap.set("n", "cN", "*``cgN")

-- Change selected word in a repeatable manner
vim.keymap.set("v", "cn", [["y/\\V\<C-r>=escape(@\", '/')\<CR>\<CR>" . "``cgn"]], { expr = true })
vim.keymap.set("v", "cn", [["y/\\V\<C-r>=escape(@\", '/')\<CR>\<CR>" . "``cgN"]], { expr = true })

-- Close windows with q
vim.keymap.set("n", "q", [[winnr('$') != 1 ? ':<C-u>close<CR>' : ':<C-u>bdelete<CR>']], {
  silent = true,
  expr = true,
})

-- Improve the behavior of '0': tobble between '^' and '0'
vim.keymap.set(
  { "n", "x", "o" },
  "0",
  "getline('.')[0 : col('.') - 2] =~# '^\\s\\+$' ? '0' : '^'",
  { expr = true, desc = "Toggle between '^' and '0'" }
)

-- Turn off search highlight
vim.keymap.set(
  { "n", "i" },
  "<ESC>",
  [[<Cmd>silent! nohlsearch<CR><ESC>]],
  { silent = true, desc = "Escape and clear hlsearch" }
)

--- }}}

--- Open/close folding: {{{
-- Focus the current fold by closing all others
vim.keymap.set("n", "<S-Return>", "zMza", { desc = "Focus the current fold by closing all others" })

-- Smart open/close fold
vim.keymap.set("n", "l", function()
  return vim.fn.foldclosed "." ~= -1 and "zo0" or "l"
end, { expr = true, desc = "Smart open fold" })

vim.keymap.set("x", "l", function()
  return vim.fn.foldclosed "." ~= -1 and "zogv0" or "l"
end, { expr = true, desc = "Smart open fold" })

vim.keymap.set("n", "<C-_>", function()
  if vim.fn.foldlevel "." == 0 then
    vim.cmd [[normal! zM]]
    return
  end

  local foldc_lnum = vim.fn.foldclosed "."
  vim.cmd [[normal! zM]]
  if foldc_lnum == -1 then
    return
  end

  if vim.fn.foldclosed "." == foldc_lnum then
    vim.cmd [[normal! zM]]
  end
end, { silent = true, desc = "Smart close fold" })

--- }}}

-- Window/Tabs operation {{{

vim.keymap.set("n", "<Space>wd", "<C-w>c", { desc = "Delete window" })
vim.keymap.set("n", "<Space>ww", "<C-w>p", { desc = "Other window" })
vim.keymap.set("n", "<Space>w-", "<C-w>s", { desc = "Split window below" })
vim.keymap.set("n", "<Space>w|", "<C-w>v", { desc = "Split window right" })
vim.keymap.set("n", "<Space>w=", "<C-w>v", { desc = "Equal size window" })

-- Resize window by Shift+arrow => use smart-splits.nvim
-- vim.keymap.set("n", "<S-Left>", "<C-w><", { desc = "Decrease window width" })
-- vim.keymap.set("n", "<S-Right>", "<C-w>>", { desc = "Increase window width" })
-- vim.keymap.set("n", "<S-Up>", "<C-w>+", { desc = "Increase window height" })
-- vim.keymap.set("n", "<S-Down>", "<C-w>-", { desc = "Decrease window height" })

-- new tab
vim.keymap.set("n", "<Space><Tab><Tab>", "<Cmd>tabnew<CR>", { desc = "New Tab" })
vim.keymap.set("n", "<Space><Tab>]", "<Cmd>tabnext<CR>", { desc = "Next Tab" })
vim.keymap.set("n", "<Space><Tab>[", "<Cmd>tabprevious<CR>", { desc = "Previous Tab" })
vim.keymap.set("n", "<Space><Tab>d", "<Cmd>tabclose<CR>", { desc = "Close Tab" })
vim.keymap.set("n", "<Space><Tab>f", "<Cmd>tabfirst<CR>", { desc = "First Tab" })
vim.keymap.set("n", "<Space><Tab>l", "<Cmd>tablast<CR>", { desc = "Last Tab" })

---  }}}

--- Toggle Editor UI {{{
-- toggle diagnostics
vim.keymap.set("n", "<Space>ud", utils.toggle_diagnostics, { desc = "Toggle Diagnostics" })
-- toggle list char (control characters)
vim.keymap.set("n", "<Space>uh", function()
  utils.toggle "list"
  -- vim.wo.list = not vim.wo.list
end, { silent = true, desc = "Toggle list char (control characters)" })
-- toggle line numbers
vim.keymap.set("n", "<Space>ul", function()
  -- vim.wo.number = not vim.wo.number
  -- vim.wo.relativenumber = not vim.wo.relativenumber
  utils.toggle("relativenumber", true)
  utils.toggle "number"
end, { silent = true, desc = "Toggle Line Numbers" })
-- toggle spell checking
vim.keymap.set("n", "<Space>us", function()
  utils.toggle "spell"
end, { silent = true, desc = "Toggle Spelling" })
-- toggle wrap
vim.keymap.set("n", "<Space>uw", function()
  utils.toggle "wrap"
end, { silent = true, desc = "Toggle Word Wrap" })

--- }}}

--- Leader mappings {{{
-- ;; to :
-- api.nvim_set_keymap("n", "<Leader>;",  ":", {noremap = true, silent = true})

-- Quit

vim.keymap.set("n", "<Leader>q", ":quit<CR>", { silent = true, desc = "Quit" })
vim.keymap.set("v", "<Leader>q", "<ESC>:quit<CR>", { silent = true, desc = "Quit" })
vim.keymap.set("n", "<Leader>Q", ":qall!<CR>", { silent = true, desc = "Quit all" })
vim.keymap.set("v", "<Leader>Q", "<ESC>:qall!<CR>", { silent = true, desc = "Quit all" })

-- Fast saving
vim.keymap.set("n", "<Leader>w", "<Cmd>update<CR>", { silent = true, desc = "Update file" })
vim.keymap.set("v", "<Leader>w", "<ESC>:update<CR>", { silent = true, desc = "Update file" })
vim.keymap.set("n", "<Leader>W", "<Cmd>wall!<CR>", { silent = true, desc = "Save all" })
vim.keymap.set("v", "<Leader>W", "<ESC>:wall!<CR>", { silent = true, desc = "Save all" })
--- }}}
