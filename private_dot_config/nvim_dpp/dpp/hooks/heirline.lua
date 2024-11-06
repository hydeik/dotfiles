--- [heirline.nvim](https://github.com/rebelot/heirline.nvim)
--- Heirline.nvim is a no-nonsense Neovim Statusline plugin designed around
--- recursive inheritance to be exceptionally fast and versatile.

-- lua_source {{{
vim.opt.laststatus = 3
vim.opt.showcmdloc = "statusline"

local conditions = require "heirline.conditions"
local utils = require "heirline.utils"
local setup_colors = require("rc.plugins.heirline.colors").setup_colors

require("heirline").setup {
  statusline = require "rc.plugins.heirline.statusline",
  statuscolumn = require "rc.plugins.heirline.statuscolumn",
  winbar = require "rc.plugins.heirline.winbar",
  opts = {
    disable_winbar_cb = function(args)
      if vim.bo[args.buf].filetype == "neo-tree" then
        return
      end
      return conditions.buffer_matches({
        buftype = { "nofile", "prompt", "help", "quickfix" },
        filetype = { "^git.*", "fugitive", "Trouble", "dashboard", "oil" },
      }, args.buf)
    end,
    colors = setup_colors,
  },
}

vim.o.statuscolumn = require("heirline").eval_statuscolumn()

local group = vim.api.nvim_create_augroup("Heirline", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = "*",
  callback = function()
    local bh = vim.bo.bufhidden
    if bh == "wipe" or bh == "delete" then
      vim.bo.buflisted = false
    end
  end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
  group = group,
  callback = function()
    utils.on_colorscheme(setup_colors)
  end,
  desc = "Set colors for statusline",
})
-- }}}
