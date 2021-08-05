local M = {}

function M.config()
  require("indent_guides").setup {
    indent_levels = 30,
    indent_guide_size = 1,
    indent_start_level = 2,
    indent_space_guides = true,
    indent_tab_guides = true,
    indent_pretty_guides = false,
    indent_soft_pattern = "\\s",
    exclude_filetypes = {
      "help",
      "denite",
      "denite-filter",
      "LuaTree",
      "NvimTree",
      "startify",
      "vista",
      "vista_kind",
      "sagehover",
      "tagbar",
    },
    even_colors = { fg = "NONE", bg = "#49464e" },
    odd_colors = { fg = "NONE", bg = "#3b383e" },
  }
end

return M
