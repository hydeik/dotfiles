local M = {}

function M.setup()
  local keymap = require "rc.core.keymap"
  keymap.nmap { "<C-a>", "<Plug>(dial-increment)" }
  keymap.nmap { "<C-x>", "<Plug>(dial-decrement)" }
  keymap.vmap { "<C-a>", "<Plug>(dial-increment)" }
  keymap.vmap { "<C-x>", "<Plug>(dial-decrement)" }
  keymap.vmap { "g<C-a>", "<Plug>(dial-increment-additional)" }
  keymap.vmap { "g<C-x>", "<Plug>(dial-decrement-additional)" }
end

return M
