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
vim.keymap.set({ "n", "x", "o" }, "0", "getline('.')[0 : col('.') - 2] =~# '^\\s\\+$' ? '0' : '^'", { expr = true })

-- Turn off search highlight
-- vim.keymap.set("n", "<ESC><ESC>", [[<Cmd>silent! nohlsearch<CR>]], { silent = true })

--- }}}

--- Open/close folding: {{{
-- Focus the current fold by closing all others
vim.keymap.set("n", "<S-Return>", "zMza")

-- Smart open/close fold
vim.keymap.set("n", "l", function()
  return vim.fn.foldclosed "." ~= -1 and "zo0" or "l"
end, { expr = true })

vim.keymap.set("x", "l", function()
  return vim.fn.foldclosed "." ~= -1 and "zogv0" or "l"
end, { expr = true })

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
  return
end, { silent = true })

--- }}}

-- Window/Tabs operation {{{
-- Use 's' key as the prefix to control window/tab

-- new tab
vim.keymap.set("n", "st", "<Cmd>tabnew<CR>", { silent = true })

-- close window
vim.keymap.set("n", "sc", "<Cmd>close<CR>", { silent = true })

-- only current window
vim.keymap.set("n", "so", "<Cmd>only<CR>", { silent = true })

-- split window horizontally
vim.keymap.set("n", "s-", "<Cmd>split<CR>", { silent = true })

-- split window virtically
vim.keymap.set("n", "s|", "<Cmd>vsplit<CR>", { silent = true })

-- equal size window
vim.keymap.set("n", "s=", "<C-w>=<CR>", { silent = true })

-- Resize window by Shift+arrow
vim.keymap.set("n", "<S-Left>", "<C-w><")
vim.keymap.set("n", "<S-Right>", "<C-w>>")
vim.keymap.set("n", "<S-Up>", "<C-w>+")
vim.keymap.set("n", "<S-Down>", "<C-w>-")

---  }}}

--- Toggle Editor UI {{{
-- toggle cursorcolumn
vim.keymap.set("n", "<Space>tc", function()
  vim.wo.cursorcolumn = not vim.wo.cursorcolumn
end, { silent = true })

-- toggle cursorline
vim.keymap.set("n", "<Space>tl", function()
  vim.wo.cursorline = not vim.wo.cursorline
end, { silent = true })

-- toggle line numbers
vim.keymap.set("n", "<Space>tn", function()
  vim.wo.number = not vim.wo.number
  vim.wo.relativenumber = not vim.wo.relativenumber
end, { silent = true })

-- toggle spell checking
vim.keymap.set("n", "<Space>ts", function()
  vim.wo.spell = not vim.wo.spell
  if vim.wo.spell then
    vim.api.nvim_echo({ { "spell-checking " }, { "enabled", "Green" } }, false, {})
  else
    vim.api.nvim_echo({ { "spell-checking " }, { "disabled", "Red" } }, false, {})
  end
end, { silent = true })

-- toggle list char (control characters)
vim.keymap.set("n", "<Space>th", function()
  vim.wo.list = not vim.wo.list
end, { silent = true })

-- toggle wrap
vim.keymap.set("n", "<Space>tw", function()
  vim.wo.wrap = not vim.wo.wrap
  vim.wo.breakindent = not vim.wo.breakindent
end, { silent = true })

--- }}}

--- Leader mappings {{{
-- ;; to :
-- api.nvim_set_keymap("n", "<Leader>;",  ":", {noremap = true, silent = true})

-- Quit

vim.keymap.set("n", "<Leader>q", ":quit<CR>", { silent = true })
vim.keymap.set("v", "<Leader>q", "<ESC>:quit<CR>", { silent = true })
vim.keymap.set("n", "<Leader>Q", ":qall!<CR>", { silent = true })
vim.keymap.set("v", "<Leader>Q", "<ESC>:qall!<CR>", { silent = true })

-- Fast saving
vim.keymap.set("n", "<Leader>w", "<Cmd>update<CR>", { silent = true })
vim.keymap.set("v", "<Leader>w", "<ESC>:update<CR>", { silent = true })
vim.keymap.set("n", "<Leader>W", "<Cmd>wall!<CR>", { silent = true })
vim.keymap.set("v", "<Leader>W", "<ESC>:wall!<CR>", { silent = true })
--- }}}
