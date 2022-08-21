local plugin = require('rc.core.pack').register_plugin

-- plenary: full; complete; entire; absolute; unqualified.
-- All the lua functions I don't want to write twice.
plugin { "nvim-lua/plenary.nvim", module = "plenary" }

-- [WIP] An implementation of the popup API from vim in Neovim.
-- Hope to upstream when complete.
plugin { "nvim-lua/popup.nvim", module = "popup" }

-- SQLite/LuaJIT binding for lua and neovim
plugin { "tami5/sqlite.lua", module = "sqlite" }

-- repeat.vim: enable repeatable supported plugin maps with "."
plugin { "tpope/vim-repeat" }

-- Fix CursorHold Performance
-- TODO: remove it if https://github.com/neovim/neovim/issues/12587 is fixed.
plugin {
  "antoinemadec/FixCursorHold.nvim",
  config = function()
    vim.g.cursorhold_updatetime = 100
  end,
}
