--- ~/.config/nvim/rc/user/gui.lua
--- Configuration specific to NeoVim GUI
local platform = require "rc.core.platform"
local path = require "rc.core.path"

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

set_envs()
