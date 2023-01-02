local M = {
  enabled = false,
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
}

M.config = function()
  require("lualine").setup {}
end

return M
