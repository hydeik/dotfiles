return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruff_lsp = {},
      },
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "python" })
      end
    end,
  },
  -- {
  --   "linux-cultist/venv-selector.nvim",
  --   event = "VeryLazy",
  --   opts = {
  --     name = { "venv", ".venv" },
  --   }
  -- }
}
