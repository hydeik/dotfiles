local M = {}

function M.config()
  -- custom components
  local my_location = function()
    return [[ %3l  %-2v]]
  end
  require("lualine").setup {
    options = {
      theme = "nightfox",
      section_separators = { "", "" },
      component_separators = { "", "" },
    },
    sections = {
      lualine_a = { { "mode", upper = true } },
      lualine_b = {
        {
          "filename",
          file_status = true, -- diplays readonly & modified status
          path = 1, -- relative path
        },
      },
      lualine_c = {
        { "branch", icon = "", separator = "" },
        {
          "diff",
          separator = "",
          symbols = {
            added = " ",
            removed = " ",
            modified = " ",
          },
        },
      },
      lualine_x = {
        {
          "diagnostics",
          sources = { "nvim_lsp" },
          symbols = { error = " ", warn = " ", info = " ", hint = " " },
        },
        { "encoding" },
        { "fileformat" },
        { "filetype" },
      },
      lualine_y = { "progress" },
      lualine_z = { my_location },
    },
    extensions = { "quickfix" },
  }
end

return M
