-- Profile
if vim.env.PROF then
  local snacks = vim.fn.stdpath "data" .. "/lazy/snacks.nvim"
  vim.opt.runtimepath:append(snacks)
  ---@diagnostic disable-next-line: missing-fields
  require("snacks.profiler").startup {
    startup = { "VeryLazy" },
  }
end

--- Load nvim configurations
local load_core = function()
  -- load options here, before lazy init while sourcing plugin modules
  -- this is needed to make sure options will be correctly applied
  -- after installing missing plugins
  require "rc.core.options"

  -- Load plugins
  require "rc.core.lazy"

  if vim.fn.argc(-1) == 0 then
    -- autocmds and keymaps can wait to load
    vim.api.nvim_create_autocmd("User", {
      group = vim.api.nvim_create_augroup("LazyVim", { clear = true }),
      pattern = "VeryLazy",
      callback = function()
        require "rc.core.autocmds"
        require "rc.core.keymaps"
      end,
    })
  else
    -- load them now so they affect the opened buffers
    require "rc.core.autocmds"
    require "rc.core.keymaps"
  end

  local conf = require "rc.core.config"
  if type(conf.colorscheme) == "function" then
    conf.colorscheme()
  else
    vim.cmd.colorscheme(conf.colorscheme)
  end
end

load_core()
