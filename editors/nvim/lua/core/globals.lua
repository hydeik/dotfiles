local globals = {}

local home = os.getenv "HOME"

-- OS type detection
local os_name = vim.loop.os_uname().sysname
local is_mac = os_name == "Darwin"
local is_linux = os_name == "Linux"
local is_windows = os_name == "Windows"
local path_sep = is_windows and "\\" or "/"

-- Directories to store nvim data
local config_dir = vim.fn.stdpath "config"
local cache_dir = vim.fn.stdpath "cache"
local data_dir = vim.fn.stdpath "data"

local nvim_dir = {
  config = config_dir,
  cache = cache_dir,
  data = data_dir,
  backup = data_dir .. path_sep .. "backup",
  swap = data_dir .. path_sep .. "swap",
  undo = data_dir .. path_sep .. "undo",
  view = data_dir .. path_sep .. "view",
  site_packages = data_dir .. path_sep .. "site",
}

function globals:load_variables()
  self.is_mac = is_mac
  self.is_linux = is_linux
  self.is_windows = is_windows
  self.config_dir = config_dir
  self.cache_dir = cache_dir
  self.nvim_dir = nvim_dir
  self.home = home
  self.path_sep = path_sep
end

local function is_empty_string(str)
  return str == nil or str == ""
end

local function is_directory(filename)
  local stat = vim.loop.fs_stat(filename)
  return stat and stat.type == "directory" or false
end

local function configure_path(new_paths, path_var)
  local path_separator = globals.is_windows and ";" or ":"
  local paths = {}

  local add_paths = function(list)
    for _, x in ipairs(list) do
      if not is_empty_string(x) then
        local y = vim.fn.expand(x)
        if is_directory(y) and not vim.tbl_contains(paths, y) then
          paths[#paths + 1] = y
        end
      end
    end
  end
  -- Split path_var string with the separator, and filter out non-exsiting dirs
  if not is_empty_string(path_var) then
    add_paths(vim.split(path_var, path_separator, true))
  end
  -- Add given directories in the path list.
  add_paths(new_paths)
  -- concat paths
  return table.concat(paths, path_separator)
end

function globals:set_envs()
  -- Set PATH so that Nvim GUI frontend can recognize these variables
  vim.env.PATH = configure_path({
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

  -- vim.env.MANPATH = configure_path({
  --   "~/.local/share/man",
  --   "/usr/share/man/",
  --   "/usr/local/share/man/ja",
  --   "/usr/local/share/man/",
  --   "/Applications/Xcode.app/Contents/Developer/usr/share/man",
  --   "/opt/intel/man/",
  -- }, os.getenv "MANPATH")
end

-- Some variables used in configuration files
globals:load_variables()

-- Environment variables
globals:set_envs()

return globals
