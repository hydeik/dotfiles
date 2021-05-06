--- ~/.config/nvim/core/init.lua
local globals = require("core.globals")
local opt = vim.opt

--- Ensure cache and data directories exist
local function ensure_nvim_dirs()
  -- NOTE: this function must be called after setting ENVS
  vim.fn.mkdir(globals.nvim_dir.backup, "p")
  vim.fn.mkdir(globals.nvim_dir.swap, "p")
  vim.fn.mkdir(globals.nvim_dir.undo, "p")
  vim.fn.mkdir(globals.nvim_dir.view, "p")
  vim.fn.mkdir(globals.nvim_dir.site_packages, "p")
end

--- Set nvim built-in global options on startup
local function set_encodings()
  -- Set default text encoding
  opt.encoding = "utf-8"
  -- List of character encodings considered when starting to edit an existing file
  opt.fileencodings =
    "ucs-bom,utf-8,euc-jp,iso-2022-jp,cp932,utf-16,utf-16le,cp1250"

  -- IME setting
  if vim.fn.has("multi_byte_ime") then
    opt.iminsert = 0
    opt.imsearch = 0
  end
end

local function enable_truecolor()
  --[[
    Enable true color if supported.

    TODO: We should check if the terminal emulater has truecolor supports, but
    there is no reliable ways to do that. Some terminal emulater provides
    $COLORTERM environment variable set to 'truecolor' or '24bit' so we also
    checkt this variable.
  --]]
  -- local colorterm = os.getenv("COLORTERM")
  -- if vim.fn.has("termguicolors") and (colorterm == "truecolor" or colorterm == "24bit") then
  --   vim.o.termguicolors = true
  -- end
  opt.termguicolors = true
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
  -- Set Node.js provider
  vim.g.node_host_prog = vim.env.XDG_DATA_HOME .. "/npm/bin/neovim-node-host"
  -- Disable python2/ruby/perl support in neovim
  vim.g.loaded_python_provider = 0
  vim.g.loaded_ruby_provider = 0
  vim.g.loaded_perl_provider = 0
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
  vim.g.loaded_matchit = 1
  vim.g.loaded_matchparen = 1
  vim.g.netrw_nogx = 1
  vim.g.loaded_netrwPlugin = 1
  vim.g.loaded_netrwSettings = 1
  vim.g.loaded_netrwFileHandlers = 1
  vim.g.loaded_rrhelper = 1
  vim.g.loaded_spellfile_plugin = 1
  vim.g.loaded_tar = 1
  vim.g.loaded_tarPlugin = 1
  vim.g.loaded_vimball = 1
  vim.g.loaded_vimballPlugin = 1
  vim.g.loaded_zip = 1
  vim.g.loaded_zipPlugin = 1
end

--- Run
ensure_nvim_dirs()
disable_builtin_plugins()
set_encodings()
enable_truecolor()
set_providers()
set_prefix_keys()

