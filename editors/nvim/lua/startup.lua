--- ~/.config/nvim/core/init.lua
local globals = require "globals"

--- Ensure cache and data directories exist
local function ensure_nvim_dirs()
  -- NOTE: this function must be called after setting ENVS
  vim.fn.mkdir(globals.nvim_dir.backup, "p")
  vim.fn.mkdir(globals.nvim_dir.swap, "p")
  vim.fn.mkdir(globals.nvim_dir.undo, "p")
  vim.fn.mkdir(globals.nvim_dir.view, "p")
  vim.fn.mkdir(globals.nvim_dir.site_packages, "p")
end

--- Set nvim default global vars on startup

--- Python, Node.js providers
local function set_providers()
  --[[
    Set python3 interpretor (required to setup plugins using neovim python API).

    It is recommended to create virtualenvs for and only for neovim (install
    pynvim + development tools) and set python3_host_prog and python_host_prog
    to point the corresponding python interpreters.
  --]]
  vim.g.python3_host_prog = vim.env.HOME .. "/.asdf/shims/python3"
  -- Disable Nodejs / python2 / ruby / perl providers
  vim.g.loaded_node_provider = 0
  vim.g.loaded_perl_provider = 0
  vim.g.loaded_python_provider = 0
  vim.g.loaded_ruby_provider = 0
end

--- Set mapleader, localmapleader, and other prefix keys for keymap
local function set_prefix_keys()
  --[[ Leader/Localleader keys ]]
  vim.g.mapleader = ";"
  vim.g.maplocalleader = "\\"
  -- release keymappings for plugins
  vim.api.nvim_set_keymap("n", "<Space>", "<Nop>", { noremap = true })
  vim.api.nvim_set_keymap("x", "<Space>", "<Nop>", { noremap = true })
  vim.api.nvim_set_keymap("n", ";", "<Nop>", { noremap = true })
  vim.api.nvim_set_keymap("x", ";", "<Nop>", { noremap = true })
  vim.api.nvim_set_keymap("n", ",", "<Nop>", { noremap = true })
  vim.api.nvim_set_keymap("x", ",", "<Nop>", { noremap = true })
  vim.api.nvim_set_keymap("n", "m", "<Nop>", { noremap = true })
  vim.api.nvim_set_keymap("x", "m", "<Nop>", { noremap = true })
  vim.api.nvim_set_keymap("n", "s", "<Nop>", { noremap = true })
  vim.api.nvim_set_keymap("x", "s", "<Nop>", { noremap = true })
end

local function disable_builtin_plugins()
  --[[ Disable unnecessary default plugins ]]
  vim.g.loaded_2html_plugin = 1
  vim.g.loaded_getscript = 1
  vim.g.loaded_getscriptPlugin = 1
  vim.g.loaded_gzip = 1
  vim.g.loaded_logiPat = 1
  vim.g.loaded_man = 1
  vim.g.loaded_matchit = 1
  vim.g.loaded_matchparen = 1
  vim.g.netrw_nogx = 1
  vim.g.loaded_netrwFileHandlers = 1
  vim.g.loaded_netrwPlugin = 1
  vim.g.loaded_netrwSettings = 1
  vim.g.loaded_rrhelper = 1
  vim.g.loaded_spellfile_plugin = 1
  vim.g.loaded_tar = 1
  vim.g.loaded_tarPlugin = 1
  vim.g.loaded_tutor_mode_plugin = 1
  vim.g.loaded_vimball = 1
  vim.g.loaded_vimballPlugin = 1
  vim.g.loaded_zip = 1
  vim.g.loaded_zipPlugin = 1
end

--- Run
ensure_nvim_dirs()
disable_builtin_plugins()
set_providers()
set_prefix_keys()
