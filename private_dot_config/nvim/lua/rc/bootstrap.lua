--- ~/.config/nvim/rc/bootstrap.lua
local platform = require "rc.core.platform"
local path = require "rc.core.path"
local plugins = require "rc.plugins"

--- Set enviromnent variables (mainly for Neovim GUI).
local function is_empty_string(str)
  return str == nil or str == ""
end

local function build_path_var(new_paths, path_var)
  local sep = platform.is_windows and ";" or ":"
  local paths = {}

  local add_paths = function(list)
    for _, x in ipairs(list) do
      if not is_empty_string(x) then
        local y = vim.fn.expand(x)
        if path.is_dir(y) and not vim.tbl_contains(paths, y) then
          paths[#paths + 1] = y
        end
      end
    end
  end
  -- Split path_var string with the separator, and filter out non-exsiting dirs
  if not is_empty_string(path_var) then
    add_paths(vim.split(path_var, sep, true))
  end
  -- Add given directories in the path list.
  add_paths(new_paths)
  -- concat paths
  return table.concat(paths, sep)
end

local function set_envs()
  -- Set PATH so that Nvim GUI frontend can recognize these variables
  vim.env.PATH = build_path_var({
    "~/.poetry/bin",
    "~/.yarn/bin",
    "~/.cargo/bin",
    "~/.luarock/bin",
    "~/.asdf/bin",
    "~/.asdf/shims",
    "~/.local/bin",
    "~/.local/share/gem/bin",
    "~/.local/share/npm/bin",
    "~/bin",
    "/Library/Tex/texbin",
    "/usr/local/bin",
    "/usr/bin",
    "/bin",
    "/usr/local/sbin",
    "/usr/sbin",
    "/sbin",
  }, os.getenv "PATH")

  vim.env.MANPATH = build_path_var({
    "~/.local/share/man",
    "/usr/share/man/",
    "/usr/local/share/man/ja",
    "/usr/local/share/man/",
    "/Applications/Xcode.app/Contents/Developer/usr/share/man",
    "/opt/intel/man/",
  }, os.getenv "MANPATH")
end

local function set_packpath()
  vim.o.packpath = path.join(path.data_home, "site")
  -- vim.o.packpath = ""
end

--- Disable unnecessary default plugins
local function disable_builtin_plugins()
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

  -- Disable $VIMRUNTIME/filetype.vim and use $VIMRUNTIME/filetype.lua for
  -- file type detection
  vim.g.do_filetype_lua = 1
  vim.g.did_load_filetypes = 0
  -- Also disable $VIMRUNTIME/{indent,ftplugin}.vim
  vim.g.did_indent_on = 1
  vim.g.did_load_ftplugin = 1
end

--- Python, Node.js providers
local function set_providers()
  --[[
    Set python3 interpretor (required to setup plugins using neovim python API).

    It is recommended to create virtualenvs for and only for neovim (install
    pynvim + development tools) and set python3_host_prog and python_host_prog
    to point the corresponding python interpreters.
  --]]
  vim.g.python3_host_prog = path.join(path.home, ".asdf", "shims", "python3")
  -- Disable Nodejs / python2 / ruby / perl providers
  vim.g.loaded_node_provider = 0
  vim.g.loaded_perl_provider = 0
  vim.g.loaded_python_provider = 0
  vim.g.loaded_ruby_provider = 0
end

--- Ensure cache and data directories exist
local function ensure_nvim_dirs()
  vim.fn.mkdir(path.join(path.data_home, "backup"), "p")
  vim.fn.mkdir(path.join(path.data_home, "swap"), "p")
  vim.fn.mkdir(path.join(path.data_home, "undo"), "p")
  vim.fn.mkdir(path.join(path.data_home, "view"), "p")
  vim.fn.mkdir(path.pack_root, "p")
end

--- Set mapleader, localmapleader, and other prefix keys for keymap
local function init_prefix_keys()
  --[[ Leader/Localleader keys ]]
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

--- Run
local function init()
  if vim.fn.has "gui_running" == 1 then
    -- Set PATH and MANPATH
    set_envs()
  end

  set_packpath()
  disable_builtin_plugins()
  set_providers()
  ensure_nvim_dirs()
  init_prefix_keys()

  plugins.bootstrap(function(installed)
    if installed then
      -- Automatically set up plugin configuration after cloning packer.nvim.
      vim.cmd [[autocmd User PackerComplete ++once lua require("rc.main")]]
      plugins.sync()
    else
      -- packer.nvim is not required on startup, so just require main configuration file
      require "rc.main"
    end
  end)
end

init()
