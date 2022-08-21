local plugin = require("rc.core.pack").register_plugin
local conf = require("rc.modules.cmp.config")

-- A super powerful autopair plugin for Neovim that supports multiple characters.
plugin {
  "windwp/nvim-autopairs",
  module = { "nvim-autopairs" },
  event = { "InsertEnter" },
  config = function()
    require("nvim-autopairs").setup {
      disabled_filetype = { "TelescopePrompt" },
      map_cr = false,
    }
  end
}

-- Snippet Engine for Neovim written in Lua.
plugin {
  "L3MON4D3/LuaSnip",
  module = { "luasnip" },
  event = { "InsertEnter" },
  requires = {
    { "rafamadriz/friendly-snippets" },
  },
  config = conf.luasnip.config,
}

-- A completion plugin for neovim coded in Lua.
plugin {
  "hrsh7th/nvim-cmp",
  event = { "InsertEnter" },
  after = { "LuaSnip", "nvim-autopairs" },
  config = conf.nvim_cmp.config,
}

-- nvim-cmp sources & extensions
plugin {
  "hrsh7th/cmp-nvim-lsp",
  after = "nvim-cmp",
}

plugin {
  "hrsh7th/cmp-nvim-lsp-document-symbol",
  after = "nvim-cmp",
}

plugin {
  "hrsh7th/cmp-nvim-lsp-signature-help",
  after = "nvim-cmp",
}

plugin {
  "hrsh7th/cmp-buffer",
  after = "nvim-cmp",
}

plugin {
  "hrsh7th/cmp-calc",
  after = "nvim-cmp",
}

plugin {
  "hrsh7th/cmp-cmdline",
  after = "nvim-cmp",
}
plugin {
  "hrsh7th/cmp-emoji",
  after = "nvim-cmp",
}
plugin {
  "hrsh7th/cmp-nvim-lua",
  after = "nvim-cmp",
}
plugin {
  "hrsh7th/cmp-path",
  after = "nvim-cmp",
}

plugin {
  "kdheepak/cmp-latex-symbols",
  after = "nvim-cmp",
}

plugin {
  "saadparwaiz1/cmp_luasnip",
  after = "nvim-cmp",
}

plugin {
  "ray-x/cmp-treesitter",
  after = "nvim-cmp",
}
