local M = {}

function M.config()
  require("indent_blankline").setup {
    char = "│",
    buftype_exclude = { "prompt", "terminal" },
    filetype_exclude = { "help", "packer" },
    use_treesitter = true,
    show_first_indent_level = false,
    show_current_context = true,
    show_end_of_line = true,
  }
end

return M
