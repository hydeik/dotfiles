-- Neovim plugin to improve the default vim.ui interfaces
return {
  "stevearc/dressing.nvim",
  event = "VeryLazy",
  config = function()
    require("dressing").setup {}
  end,
}
