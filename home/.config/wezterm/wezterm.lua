local wezterm = require "wezterm"
local config = {}

config.color_scheme = "catppuccin-mocha"
config.default_prog = { "bash", "-l" }

config.set_environment_variables = {
  XDG_CONFIG_HOME = os.getenv "HOME" .. "/.config",
  XDG_DATA_HOME = os.getenv "HOME" .. "/.local/share",
}

config.font = wezterm.font "Maple Mono NL NF"
config.font_size = 14.0

return config
