local plugin = require("rc.core.pack").register_plugin
local conf = require("rc.modules.treesitter.config")

-- Nvim Treesitter configurations and abstraction layer
plugin {
  "nvim-treesitter/nvim-treesitter",
  event = "BufRead",
  run = ":TSUpdate",
  config = conf.nvim_treesitter.config,
}

-- [ Treesitter extensions ]

-- Syntax aware text-objects, select, move, swap, and peek support.
plugin {
  "nvim-treesitter/nvim-treesitter-textobjects",
  after = "nvim-treesitter",
}
-- Treesitter playground integrated into Neovim
plugin {
  "nvim-treesitter/playground",
  after = "nvim-treesitter",
}

-- Rainbow parentheses for neovim using tree-sitter.
plugin {
  "p00f/nvim-ts-rainbow",
  after = "nvim-treesitter",
}

-- Neovim treesitter plugin for setting the commentstring based on the cursor location in a file.
plugin {
  "JoosepAlviste/nvim-ts-context-commentstring",
  after = "nvim-treesitter",
  module = "ts_context_commentstring",
}

-- Yet another tree-sitter powered indent plugin for Neovim.
plugin {
  "yioneko/nvim-yati",
  after = "nvim-treesitter",
}

-- [Other textobjects & operators powered by treesitter]

-- Interactively select and swap function arguments, list elements, and more. Powered by tree-sitter.
plugin {
  "mizlan/iswap.nvim",
  cmd = { "ISwap", "ISwapWith" },
  requires = { "nvim-treesitter" },
  setup = conf.iswap.setup,
}

-- A Neovim plugin to deal with treesitter units
plugin {
  "David-Kunz/treesitter-unit",
  module = { "treesitter-unit" },
  requires = { "nvim-treesitter" },
  setup = conf.treesitter_unit.setup,
}
