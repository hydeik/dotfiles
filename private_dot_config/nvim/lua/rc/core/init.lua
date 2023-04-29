--- Configure providers
local configure_providers = function()
  -- vim.g.python3_host_prog = vim.env.HOME .. "/.asdf/shims/python3"
  vim.g.python3_host_prog = 0
  vim.g.loaded_node_provider = 0
  vim.g.loaded_perl_provider = 0
  vim.g.loaded_ruby_provider = 0
end

--- Set prefix keys for plugin to use
local init_prefix_keys = function()
  vim.g.mapleader = ";"
  vim.g.maplocalleader = "\\"
  -- release keymappings for plugins
  vim.keymap.set("n", "<Space>", "<Nop>")
  vim.keymap.set("x", "<Space>", "<Nop>")
  vim.keymap.set("n", ";", "<Nop>")
  vim.keymap.set("x", ";", "<Nop>")
  vim.keymap.set("n", ",", "<Nop>")
  vim.keymap.set("x", ",", "<Nop>")
  vim.keymap.set("n", "m", "<Nop>")
  vim.keymap.set("x", "m", "<Nop>")
  vim.keymap.set("n", "s", "<Nop>")
  vim.keymap.set("x", "s", "<Nop>")
end

--- Load nvim configurations
local load_core = function()
  configure_providers()
  init_prefix_keys()

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
