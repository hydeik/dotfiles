return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "nu" } },
  },
  {
    "nvim/nvim-lspconfig",
    opts = {
      servers = {
        nushell = {},
      },
    },
  },
}
