-- A fancy, configurable, notification manager for NeoVim
return {
  "rcarriga/nvim-notify",
  keys = {
    {
      "<Space>un",
      function()
        require("notify").dismiss { silent = true, pending = true }
      end,
      desc = "Delete all Notifications",
    },
  },
  opts = {
    -- background_colour = "#000000",
    timeout = 2000,
    max_height = function()
      return math.floor(vim.o.lines * 0.75)
    end,
    max_width = function()
      return math.floor(vim.o.columns * 0.75)
    end,
  },
  init = function()
    local util = require "rc.util"
    if not util.has_plugin "noice.nvim" then
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          vim.notify = require "notify"
        end,
      })
    end
  end,
}
