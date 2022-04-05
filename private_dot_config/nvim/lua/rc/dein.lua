local platform = require "rc.core.platform"

local dein = setmetatable({}, {
  __index = function(_, key)
    return vim.fn["dein#" .. key]
  end,
})

dein.min = setmetatable({}, {
  __index = function(_, key)
    return vim.fn["dein#min#" .. key]
  end,
})

-- ~/.local/share/nvim/dein
local dein_base_path = vim.fn.stdpath("data") .. "/dein"

-- Configure dein
vim.g["dein#auto_recache"] = not platform.is_windows
vim.g["dein#enable_notification"] = true
vim.g["dein#lazy_rplugins"] = true
vim.g["dein#install_check_diff"] = true
vim.g["dein#install_max_processes"] = 16
vim.g["dein#install_progress_type"] = "floating"
-- vim.g["dein#install_log_filename"] = path.joip(path.cache_home, "dein.log")

if dein.min.load_state(dein_base_path) == 1 then
  local config_home = vim.fn.stdpath("config")
  local plugins_toml = config_home .. "/dein/plugins.toml"
  local plugins_lazy_toml = config_home .. "/dein/plugins_lazy.toml"

  dein.begin(dein_base_path, {
    plugins_toml,
    plugins_lazy_toml,
  })

  dein.load_toml(plugins_toml, { lazy = 0 })
  dein.load_toml(plugins_lazy_toml, { lazy = 1 })

  dein["end"]()
  dein.save_state()
end

if vim.fn.has("vim_starting") == 1 and dein.check_install() ~= 0 then
  dein.install()
end
