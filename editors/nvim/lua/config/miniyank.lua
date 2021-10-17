local M = {}

function M.setup()
  vim.g.miniyank_maxitems = 100
  local keymap = require "rc.core.keymap"
  keymap.nmap { "p", "<Plug>(miniyank-autoput)" }
  keymap.nmap { "P", "<Plug>(miniyank-autoPut)" }
end

return M
