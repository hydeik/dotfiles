return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        bashls = {
          settings = {
            filetypes = { "bash", "sh", "zsh" },
          },
        },
      },
    },
  },
}
