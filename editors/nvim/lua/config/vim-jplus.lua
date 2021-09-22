local M = {}

function M.setup()
  local keymap = require "utils.keymap"
  keymap.nmap { "J", "<Plug>(jplus)" }
  keymap.vmap { "J", "<Plug>(jplus)" }
  keymap.nmap { "<Leader>J", "<Plug>(jplus-input)" }
  keymap.vmap { "<Leader>J", "<Plug>(jplus-input)" }
end

return M
