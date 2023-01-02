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

  -- Set global options
  require("rc.core.options")
  -- Load plugins
  require("rc.core.lazy")

  vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
      -- Define augroup and autocmds
      require("rc.core.autocmds")
      -- Define key mappings for Neovim built-in functionality
      require("rc.core.mappings")
    end,
  })
end

load_core()
