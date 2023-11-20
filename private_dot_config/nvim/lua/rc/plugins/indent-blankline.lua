-- Indent guides for Neovim
return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    indent = {
      char = "│",
    },
    exclude = {
      buftypes = {
        "prompt",
        "terminal",
        "nofile",
      },
      filetypes = {
        "help",
        "man",
        "lspinfo",
        "checkhealth",
        "alpha",
        "startify",
        "dashboard",
        "packer",
        "neogitstatus",
        "NvimTree",
        "neo-tree",
        "Trouble",
        "lazy",
        "",
      },
    },
  },
}
