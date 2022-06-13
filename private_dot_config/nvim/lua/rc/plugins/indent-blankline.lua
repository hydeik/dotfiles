-- [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)
--
-- Indent guides for Neovim
--
return {
  "lukas-reineke/indent-blankline.nvim",
  requires = { "nvim-treesitter" },
  event = { "FocusLost", "CursorHold" },
  config = function()
    require("indent_blankline").setup {
      char = "│",
      buftype_exclude = { "prompt", "terminal" },
      filetype_exclude = { "help", "packer" },
      use_treesitter = true,
      show_first_indent_level = false,
      show_current_context = true,
      show_end_of_line = true,
    }
  end,
}
