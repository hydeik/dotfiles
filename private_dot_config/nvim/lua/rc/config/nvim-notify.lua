local M = {}

function M.setup()
  vim.opt.termguicolors = true
  local notify = require("notify")
  notify.setup {
    background_colour = "Statusline"
  }
  vim.notify = notify
end

return M
