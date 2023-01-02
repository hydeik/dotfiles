-- A fancy, configurable, notification manager for NeoVim
local M = {
  "rcarriga/nvim-notify",
}

M.config = function()
  require("notify").setup {
    background_colour = "#000000",
    -- background_colour = "#1E1E2",
    timeout = 2000,
    fps = 20,
  }
end

return M
