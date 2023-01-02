-- A blazing fast and easy to configure neovim statusline plugin written in pure lua.
local M = {
  enabled = false,
  "akinsho/bufferline.nvim",
  event = "BufAdd",
}

M.config = function()
  require("bufferline").setup {
    options = {
      numbers = "ordinal",
      indicator = {
        icon = "▎",
        style = "icon",
      },
      diagnostics = "nvim_lsp",
      always_show_bufferline = true,
      show_buffer_close_icons = false,
      show_close_icon = false,
    },
  }
end

return M
