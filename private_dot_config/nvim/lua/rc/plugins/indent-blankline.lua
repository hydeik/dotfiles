-- Indent guides for Neovim
local M = {
  "lukas-reineke/indent-blankline.nvim",
}

M.config = function()
  require("indent_blankline").setup {
    char = "│",
    buftype_exclude = { "prompt", "terminal", "nofile" },
    filetype_exclude = {
      "help",
      "startify",
      "dashboard",
      "packer",
      "neogitstatus",
      "NvimTree",
      "neo-tree",
      "Trouble",
    },
    use_treesitter = true,
    show_first_indent_level = false,
    show_current_context = true,
    show_end_of_line = true,
  }
end

return M
