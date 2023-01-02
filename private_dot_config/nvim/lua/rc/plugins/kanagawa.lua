local M = {
  enabled = false,
  "rebelot/kanagawa.nvim",
  lazy = false,
}

M.config = function()
  local transparent = vim.fn.exists "g:GuiLoaded" == 0
    and vim.fn.has "gui" == 0
    and vim.fn.exists "$SSH_CONNECTION" == 0

  require("kanagawa").setup {
    dimInactive = true,
    globalStatus = true,
    transparent = transparent,
    theme = "default",
  }

  vim.cmd.colorscheme "kanagawa"
end

return M
