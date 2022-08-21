local plugin = require("rc.core.pack").register_plugin
local conf = require("rc.modules.lsp.config")

-- Portable package manager for Neovim that runs everywhere Neovim runs. Easily install and manage LSP servers, DAP
-- servers, linters, and formatters.
plugin {
  "williamboman/mason.nvim",
  config = function()
    require("mason").setup {
      ui = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      }
    }
  end
}

-- Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim
plugin {
  "williamboman/mason-lspconfig.nvim",
  after = { "mason.nvim" },
  require = { "nvim-lspconfig" },
  event = { "BufReadPre" },
  config = conf.mason_lspconfig.config,
}


-- Quickstart configs for Nvim LSP
plugin {
  "neovim/nvim-lspconfig",
  module = { "lspconfig" },
  config = conf.nvim_lspconfig.config,
}

-- A plugin for setting Neovim LSP with JSON or YAML files
plugin {
  "tamago324/nlsp-settings.nvim",
  module = { "nlspsettings" },
  cmd = {
    "NlspConfig",
    "NlspLocalConfig",
    "NlspBufConfig",
    "NlspLocalBufConfig",
    "NlspUpdateSettings",
  },
}

-- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua.
plugin {
  "jose-elias-alvarez/null-ls.nvim",
  event = { "BufReadPre" },
  after = { "mason-lspconfig.nvim" },
  requires = { "plenary.nvim" },
  config = conf.null_ls.config,
}

-- Tools for better development in rust using neovim's builtin lsp
plugin {
  "simrat39/rust-tools.nvim",
  module = { "rust-tools" },
  requires = { "plenary.nvim" },
}

-- Clangd's off-spec features for neovim's LSP client.
plugin {
  "p00f/clangd_extensions.nvim",
  module = { "clangd_extensions" },
}

-- Dev setup for init.lua and plugin development with full signature help, docs and completion for the nvim lua API.
plugin {
  "folke/lua-dev.nvim",
  module = { "lua-dev" },
}

-- Simple winbar/statusline plugin that shows your current code context
plugin {
  "SmiteshP/nvim-navic",
  module = { "nvim-navic" },
  config = function()
    require("nvim-navic").setup {}
  end,
}

-- Standalone UI for nvim-lsp progress. Eye candy for the impatient.
plugin {
  "j-hui/fidget.nvim",
  after = { "mason.nvim", "mason-lspconfig.nvim", "nvim-lspconfig" },
  config = function()
    require("fidget").setup {
      sources = {
        ["null-ls"] = { ignore = true },
      }
    }
  end,
}
