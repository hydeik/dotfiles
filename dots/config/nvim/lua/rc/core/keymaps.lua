--- ~/.config/nvim/lua/mapping.lua

--[[
-----------------------------------------------------------------------------
| Commands \ Modes | Normal | Insert | Command | Visual | Select | Operator |
|------------------|--------|--------|---------|--------|--------|----------|
| map  / noremap   |    @   |   -    |    -    |   @    |   @    |    @     |
| nmap / nnoremap  |    @   |   -    |    -    |   -    |   -    |    -     |
| vmap / vnoremap  |    -   |   -    |    -    |   @    |   @    |    -     |
| omap / onoremap  |    -   |   -    |    -    |   -    |   -    |    @     |
| xmap / xnoremap  |    -   |   -    |    -    |   @    |   -    |    -     |
| smap / snoremap  |    -   |   -    |    -    |   -    |   @    |    -     |
| map! / noremap!  |    -   |   @    |    @    |   -    |   -    |    -     |
| imap / inoremap  |    -   |   @    |    -    |   -    |   -    |    -     |
| cmap / cnoremap  |    -   |   -    |    @    |   -    |   -    |    -     |
-----------------------------------------------------------------------------
--]]

local utils = require "rc.utils"
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

-- Better up/down
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

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

-- Indent by > and < instead of >> and <<
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

-- Window/Tabs operation {{{

vim.keymap.set("n", "<Space>wd", "<C-w>c", { desc = "Delete window" })
vim.keymap.set("n", "<Space>ww", "<C-w>p", { desc = "Other window" })
vim.keymap.set("n", "<Space>w-", "<C-w>s", { desc = "Split window below" })
vim.keymap.set("n", "<Space>w|", "<C-w>v", { desc = "Split window right" })
vim.keymap.set("n", "<Space>w=", "<C-w>v", { desc = "Equal size window" })

-- new tab
vim.keymap.set("n", "<Space><Tab><Tab>", "<Cmd>tabnew<CR>", { desc = "New Tab" })
vim.keymap.set("n", "<Space><Tab>]", "<Cmd>tabnext<CR>", { desc = "Next Tab" })
vim.keymap.set("n", "<Space><Tab>[", "<Cmd>tabprevious<CR>", { desc = "Previous Tab" })
vim.keymap.set("n", "<Space><Tab>d", "<Cmd>tabclose<CR>", { desc = "Close Tab" })
vim.keymap.set("n", "<Space><Tab>f", "<Cmd>tabfirst<CR>", { desc = "First Tab" })
vim.keymap.set("n", "<Space><Tab>l", "<Cmd>tablast<CR>", { desc = "Last Tab" })

-- Buffer
vim.keymap.set("n", "[b", "<cmd>bprevious<CR>", { desc = "Prev Buffer" })
vim.keymap.set("n", "]b", "<cmd>bnext<CR>", { desc = "Next Buffer" })
-- <Space>bd -> Snacks.bufdelete()
-- <Space>bo -> Snacks.bufdelete.other()
vim.keymap.set("n", "<Space>bD", "<cmd>bd<CR>", { desc = "Delete Buffer and Window" })
---  }}}

-- Diagnostic {{{

---@param count number
---@param severity? lsp.DiagnosticSeverity
local diagnostic_goto = function(count, severity)
  return function()
    vim.diagnostic.jump { count = count, float = true, severity = severity }
  end
end

vim.keymap.set("n", "<Space>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
vim.keymap.set("n", "]d", diagnostic_goto(1), { desc = "Next Diagnostic" })
vim.keymap.set("n", "[d", diagnostic_goto(-1), { desc = "Prev Diagnostic" })
vim.keymap.set("n", "]e", diagnostic_goto(1, vim.diagnostic.severity.ERROR), { desc = "Next Error" })
vim.keymap.set("n", "[e", diagnostic_goto(-1, vim.diagnostic.severity.ERROR), { desc = "Next Error" })
vim.keymap.set("n", "]w", diagnostic_goto(1, vim.diagnostic.severity.WARN), { desc = "Next Error" })
vim.keymap.set("n", "[w", diagnostic_goto(-1, vim.diagnostic.severity.WARN), { desc = "Next Error" })

-- }}}

--- Toggle Editor UI {{{
if Snacks.config.toggle and Snacks.config.toggle.enabled then
  local utils_format = require "rc.utils.format"
  utils_format.snacks_toggle(false):map "<Space>uf"
  utils_format.snacks_toggle(true):map "<Space>uF"
  Snacks.toggle.option("spell", { name = "Spelling" }):map "<Space>us"
  Snacks.toggle.option("wrap", { name = "Wrap" }):map "<Space>uw"
  Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map "<Space>uL"
  Snacks.toggle.diagnostics():map "<Space>ud"
  Snacks.toggle.line_number():map "<Space>ul"
  Snacks.toggle
    .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2, name = "Conceal Level" })
    :map "<Space>uc"
  Snacks.toggle
    .option("showtabline", { off = 0, on = vim.o.showtabline > 0 and vim.o.showtabline or 2, name = "Tabline" })
    :map "<Space>uA"
  Snacks.toggle.treesitter():map "<Space>uT"
  Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map "<Space>ub"
  Snacks.toggle.dim():map "<Space>uD"
  Snacks.toggle.animate():map "<Space>ua"
  Snacks.toggle.indent():map "<Space>ug"
  Snacks.toggle.scroll():map "<Space>uS"
  Snacks.toggle.profiler():map "<Space>dpp"
  Snacks.toggle.profiler_highlights():map "<Space>dph"

  if vim.lsp.inlay_hint then
    Snacks.toggle.inlay_hints():map "<Space>uh"
  end
else
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
end
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
