local M = {
  "gen740/SmoothCursor.nvim",
  event = "VeryLazy",
}

M.config = function()
  require("smoothcursor").setup {
    disabled_filetypes = {
      "hydra_hint",
    },
  }
end

return M
