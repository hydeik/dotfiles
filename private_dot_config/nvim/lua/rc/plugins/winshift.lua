-- Rearrange your windows with ease.
local M = {
  "sindrets/winshift.nvim",
  cmd = { "WinShift" },
}

M.config = function()
  require("winshift").setup {}
end

return M
