--- ~/.config/nvim/lua/mapping.lua
--- Set global key mappings
local api = vim.api
local nnoremap = vim.keymap.nnoremap
local inoremap = vim.keymap.inoremap
local cnoremap = vim.keymap.cnoremap
local vnoremap = vim.keymap.vnoremap
local xnoremap = vim.keymap.xnoremap
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

--- mapleader
vim.g.mapleader = ";"
vim.g.localmapleader = ","

--- Basic mappings {{{
-- Disable Ex-mode, remap to register macros
nnoremap { "Q", "q" }
nnoremap { "gQ", "@q" }

-- Disable dangerous/annoying default mappings
--   ZZ - Save current file and quit
--   ZQ - Quit without checking changes (:q!)
nnoremap { "ZZ", "<Nop>" }
nnoremap { "ZQ", "<Nop>" }

-- Useless command. M - to middle line of window
nnoremap { "M", "m" }

-- Y: yank text from cursor position to the EOL
nnoremap { "Y", "y$" }

-- Emacs-like cursor move in insert/command mode
-- NOTE: <C-f> and <C-b> are mapped in lua/conf/vim-vsnip.lua
inoremap { "<C-a>", "<Home>" }
inoremap { "<C-b>", "<Left>" }
inoremap { "<C-d>", "<Del>" }
-- inoremap { "<C-e>", "<End>" }
inoremap { "<C-f>", "<Right>" }
inoremap { "<C-k>", "<C-o>D" }

cnoremap { "<C-a>", "<Home>" }
cnoremap { "<C-b>", "<Left>" }
cnoremap { "<C-d>", "<Del>" }
cnoremap { "<C-e>", "<End>" }
cnoremap { "<C-f>", "<Right>" }
cnoremap { "<C-n>", "<Down>" }
cnoremap { "<C-p>", "<Up>" }

-- Enable undo <C-w> and <C-u> in insert mode.
inoremap { "<C-w>", "<C-g>u<C-w>" }
inoremap { "<C-u>", "<C-g>u<C-u>" }

-- <C-y>: paste
cnoremap { "<C-y>", "<C-r>*" }
-- <C-g>: exit
cnoremap { "<C-g>", "<C-c>" }

-- Indent by > and < instead of >> and <<
nnoremap { ">", ">>" }
nnoremap { "<", "<<" }

-- Maintain visual mode after shifting > and <
xnoremap { ">", ">gv" }
xnoremap { "<", "<gv" }

-- Easy escape
inoremap { "jj", "<ESC>" }
inoremap { "j ", "j" }
cnoremap {
  "j",
  [[getcmdline()[getcmdpos()-2] ==# 'j' ? "\<BS>\<C-c>" : 'j']],
  expr = true,
}

-- Start new line from any cursor position
inoremap { "<S-Return>", "<C-o>o" }

-- Change current word in a repeatable manner
nnoremap { "cn", "*``cgn" }
nnoremap { "cN", "*``cgN" }

-- Change selected word in a repeatable manner
vnoremap {
  "cn",
  [["y/\\V\<C-r>=escape(@\", '/')\<CR>\<CR>" . "``cgn"]],
  expr = true,
}

vnoremap {
  "cN",
  [["y/\\V\<C-r>=escape(@\", '/')\<CR>\<CR>" . "``cgN"]],
  expr = true,
}

-- Close windows with q
nnoremap {
  "q",
  [[winnr('$') != 1 ? ':<C-u>close<CR>' : ':<C-u>bdelete<CR>']],
  silent = true,
  expr = true,
}

-- Turn off search highlight
nnoremap { "<ESC><ESC>", [[<Cmd>silent! nohlsearch<CR>]], silent = true }

--- }}}

--- Open/close folding: {{{
-- Toggle fold
nnoremap { "<CR>", "za" }
-- Focus the current fold by closing all others
nnoremap { "<S-Return>", "zMza" }

-- Smart open/close fold
nnoremap { "l", [[foldclosed('.') != -1 ? 'zo' : 'l']], expr = true }
xnoremap { "l", [[foldclosed(line('.')) != -1 ? 'zogv0' : 'l']], expr = true }
nnoremap {
  "<C-_>",
  function()
    if vim.fn.foldlevel(".") == 0 then
      vim.cmd("normal! zM")
      return
    end

    local foldc_lnum = vim.fn.foldclosed(".")
    vim.cmd("normal! zM")
    if foldc_lnum == -1 then return end

    if vim.fn.foldclosed('.') == foldc_lnum then vim.cmd("normal! zM") end
    return
  end,
  silent = true,
}

--- }}}

-- Window/Tabs operation {{{
-- Use 's' key as the prefix to control window/tab

-- new tab
nnoremap { "st", ":tabnew<CR>", silent = true }
-- close window
nnoremap { "sc", ":close<CR>", silent = true }
-- only current window
nnoremap { "so", ":only<CR>", silent = true }

-- split window horizontally
nnoremap { "s-", ":split<CR>", silent = true }

-- split window virtically
nnoremap { "s|", ":vsplit<CR>", silent = true }

-- equal size window
nnoremap { "s=", "<C-w>=<CR>", silent = true }

-- Resize window by Shift+arrow
nnoremap { "<S-Left>", "<C-w><" }
nnoremap { "<S-Right>", "<C-w>>" }
nnoremap { "<S-Up>", "<C-w>+" }
nnoremap { "<S-Down>", "<C-w>-" }

---  }}}

--- Toggle Editor UI {{{
-- toggle cursorcolumn
nnoremap {
  "<Space>tc",
  function() vim.wo.cursorcolumn = not vim.wo.cursorcolumn end,
  silent = true,
}

-- toggle cursorline
nnoremap {
  "<Space>tl",
  function() vim.wo.cursorline = not vim.wo.cursorline end,
  silent = true,
}

-- toggle line numbers
nnoremap {
  "<Space>tn",
  function()
    vim.wo.number = not vim.wo.number
    vim.wo.relativenumber = not vim.wo.relativenumber
  end,
  silent = true,
}

nnoremap {
  "<Space>tp",
  function()
    vim.wo.paste = not vim.wo.paste
    if vim.wo.paste then
      vim.api.nvim_echo(
        { { "paste-checking " }, { "enabled", "Green" } }, false, {}
      )
    else
      vim.api.nvim_echo(
        { { "paste-checking " }, { "disabled", "Red" } }, false, {}
      )
    end
  end,
  silent = true,
}

nnoremap {
  "<Space>ts",
  function()
    vim.wo.spell = not vim.wo.spell
    if vim.wo.spell then
      vim.api.nvim_echo(
        { { "spell-checking " }, { "enabled", "Green" } }, false, {}
      )
    else
      vim.api.nvim_echo(
        { { "spell-checking " }, { "disabled", "Red" } }, false, {}
      )
    end
  end,
  silent = true,
}

nnoremap {
  "<Space>th",
  function() vim.wo.list = not vim.wo.list end,
  silent = true,
}

nnoremap {
  "<Space>tw",
  function()
    vim.wo.wrap = not vim.wo.wrap
    vim.wo.breakindent = not vim.wo.breakindent
  end,
  silent = true,
}

--- }}}

--- Leader mappings {{{
-- ;; to :
-- api.nvim_set_keymap("n", "<Leader>;",  ":", {noremap = true, silent = true})

-- Quit
api.nvim_set_keymap(
  "n", "<Leader>q", ":quit<CR>", { noremap = true, silent = true }
)
api.nvim_set_keymap(
  "v", "<Leader>q", "<ESC>:quit<CR>", { noremap = true, silent = true }
)
api.nvim_set_keymap(
  "n", "<Leader>Q", ":qall!<CR>", { noremap = true, silent = true }
)
api.nvim_set_keymap(
  "v", "<Leader>Q", "<ESC>:qall!<CR>", { noremap = true, silent = true }
)

-- Fast saving
api.nvim_set_keymap(
  "n", "<Leader>w", ":update<CR>", { noremap = true, silent = true }
)
api.nvim_set_keymap(
  "v", "<Leader>w", "<ESC>:update<CR>", { noremap = true, silent = true }
)
api.nvim_set_keymap(
  "n", "<Leader>W", ":wall!<CR>", { noremap = true, silent = true }
)
api.nvim_set_keymap(
  "v", "<Leader>W", "<ESC>:wall!<CR>", { noremap = true, silent = true }
)
--- }}}
