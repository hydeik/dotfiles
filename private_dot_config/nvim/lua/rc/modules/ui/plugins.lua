local plugin = require("rc.core.pack").register_plugin
local conf = require("rc.modules.ui.config")

-- A lua fork of vim-devicons. This plugin provides the same icons as well as colors for each icon.
plugin {
  "kyazdani42/nvim-web-devicons",
  module = { "nvim-web-devicons" },
  config = conf.nvim_web_devicons.config,
}

-- UI Component Library for Neovim
plugin {
  "MunifTanjim/nui.nvim",
  module = { "nui" },
}

-- Indent guides for Neovim
plugin {
  "lukas-reineke/indent-blankline.nvim",
  requires = { "nvim-treesitter" },
  event = { "FocusLost", "CursorHold" },
  config = conf.indent_blankline_nvim.config,
}

-- Decorate scrollbar for Neovim
plugin {
  "lewis6991/satellite.nvim",
  branch = "main",
  event = { "CursorHold", "CursorHoldI" },
  requires = { "gitsigns.nvim" },
  config = conf.satellite_nvim.config,
}

-- The fastest Neovim colorizer
plugin {
  "norcalli/nvim-colorizer.lua",
  event = { "BufReadPost" },
  config = conf.nvim_colorizer.config,
}
