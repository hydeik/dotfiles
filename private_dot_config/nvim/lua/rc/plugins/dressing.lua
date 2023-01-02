-- Neovim plugin to improve the default vim.ui interfaces
local M = {
  "stevearc/dressing.nvim",
  event = "VeryLazy",
}

M.config = function()
  require("dressing").setup {}
end

return M
