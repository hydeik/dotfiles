local path = require "rc.core.path"
local platform = require "rc.core.platform"

local dein = setmetatable({}, {
  __index = function(_, key)
    return vim.fn["dein#" .. key]
  end,
})

dein.min_load_state = vim.fn["dein#min#load_state"]

-- ~/.local/share/nvim/dein
local dein_base_path = path.join(path.cache_home, "dein")

-- Ensure dein.vim is installed.
if not string.find(vim.o.runtimepath, "/dein.vim") then
  local dein_repo_dir = path.join(dein_base_path, "repos", "Shougo", "dein.vim")
  if not path.is_dir(dein_repo_dir) then
    local dein_repo_url = "https://github.com/Shougo/dein.vim"
    vim.fn.system { "git", "clone", "--depth", "1", dein_repo_url, dein_repo_dir }
  end
  vim.opt.runtimepath:prepend(dein_repo_dir)
end

-- Configure dein
vim.g["dein#auto_recache"] = not platform.is_windows
vim.g["dein#enable_notification"] = true
vim.g["dein#lazy_rplugins"] = true
vim.g["dein#install_check_diff"] = true
vim.g["dein#install_max_processes"] = 16
vim.g["dein#install_progress_type"] = "floating"
-- vim.g["dein#install_log_filename"] = path.joip(path.cache_home, "dein.log")

if dein.min_load_state(dein_base_path) == 1 then
  local plugins_toml = path.join(path.config_home, "dein", "plugins.toml")
  local plugins_lazy_toml = path.join(path.config_home, "dein", "plugins_lazy.toml")

  dein.begin(dein_base_path, {
    plugins_toml,
    plugins_lazy_toml,
  })

  dein.load_toml(plugins_toml, { lazy = 0 })
  dein.load_toml(plugins_lazy_toml, { lazy = 1 })

  dein["end"]()
  dein.save_state()
end

if vim.fn.has "vim_starting" and dein.check_install() ~= 0 then
  dein.install()
end
