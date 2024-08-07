--- [mason.nvim](https://github.com/williamboman/mason.nvim)
--- Portable package manager for Neovim that runs everywhere Neovim runs.
--- Easily install and manage LSP servers, DAP servers, linters, and formatters.

-- lua_add {{{

-- List of packages automatically installed by Mason.
vim.g.mason_ensure_installed = {}

-- }}}

-- lua_source {{{

-- setup
require("mason").setup {
  ui = {
    server_installed = "✓",
    server_pending = "",
    server_uninstalled = "✗",
    package_installed = "✓",
    package_pending = "",
    package_uninstalled = "✗",
  },
}

require("rc.plugins.mason").ensure_installed(vim.g.mason_ensure_installed)

-- }}}
