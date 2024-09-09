--- [mini.surround](https://github.com/echasnovski/mini.surround)
-- Neovim Lua plugin with fast and feature-rich surround actions.
-- Part of 'mini.nvim' library.

-- lua_source {{{
local mappings = {
  add = "gsa", -- Add surrounding in Normal and Visual modes
  delete = "gsd", -- Delete surrounding
  find = "gsf", -- Find surrounding (to the right)
  find_left = "gsF", -- Find surrounding (to the left)
  jhighlight = "gsh", -- Highlight surrounding
  replace = "gsr", -- Replace surrounding
  update_n_lines = "gsn", -- Update `n_lines`
  suffix_last = "l", -- Suffix to search with "prev" method
  suffix_next = "n", -- Suffix to search with "next" method
}

require("mini.surround").setup {
  mappings = mappings,
}

if not vim.tbl_isempty(require("dpp").get "which-key.nvim") then
  require("which-key").add {
    { mappings.add, desc = "Add surrounding", mode = { "n", "v" } },
    { mappings.delete, desc = "Delete surrounding" },
    { mappings.find, desc = "Find right surrounding" },
    { mappings.find_left, desc = "Find left surrounding" },
    { mappings.replace, desc = "Replace surrounding" },
    { mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
  }
end
-- }}}
