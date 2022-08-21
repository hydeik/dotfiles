local plugin = require("rc.core.pack").register_plugin

local theme_name = "kanagawa"

-- NeoVim dark colorscheme inspired by the colors of the famous painting by Katsushika Hokusai.
plugin {
  "rebelot/kanagawa.nvim",
  -- event = { "VimEnter", "ColorSchemePre" },
  opt = true,
  config = require("rc.modules.theme.kanagawa").config,
  disable = theme_name ~= "kanagawa",
}

-- highly customizable theme for vim and neovim with support for lsp, treesitter and a variety of plugins.
plugin {
  "EdenEast/nightfox.nvim",
  config = require("rc.modules.theme.nightfox").config,
  disable = theme_name ~= "nightfox"
}
