return {
  vim.g.vimrc_use_biome and {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        biome = {},
      },
    },
  } or nil,
}
