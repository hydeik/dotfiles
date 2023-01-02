-- Portable package manager for Neovim that runs everywhere Neovim runs.
-- Easily install and manage LSP servers, DAP servers, linters, and formatters.
return {
  "williamboman/mason.nvim",
  config = function()
    require("mason").setup {
      ui = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
    }
  end,
}
