return {
  {
    "nvim-treesiter/nvim-treesitter",
    opts = { ensure_installed = { "fortran" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        fortls = {},
      },
    },
  },
}
