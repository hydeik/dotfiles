return {
  {
    "nvim-treesiter/nvim-treesitter",
    opts = { ensure_installed = { "git_config", "gitcommit", "git_rebase", "gitignore", "gitattributes" } },
  },
  {
    "saghen/blink.cmp",
    optional = true,
    dependencies = { "Kaiser-Yang/blink-cmp-git" },
    opts = {
      sources = {
        default = { "git" },
        providers = {
          git = {
            module = "blink-cmp-git",
            name = "Git",
            opts = {},
          },
        },
      },
    },
  },
}
