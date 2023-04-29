-- Indent guides for Neovim
return {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    char = "│",
    buftype_exclude = { "prompt", "terminal", "nofile" },
    filetype_exclude = {
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
    use_treesitter = true,
    show_first_indent_level = false,
    show_current_context = true,
    show_end_of_line = true,
  },
}
