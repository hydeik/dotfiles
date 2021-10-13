local M = {}

function M.setup()
  vim.g.niceblock_no_default_key_mappings = 1

  local keymap = require "rc.core.keymap"
  keymap.vmap { "I", "<Plug>(niceblock-I)" }
  keymap.vmap { "gI", "<Plug>(niceblock-gI)" }
  keymap.vmap { "A", "<Plug>(niceblock-A)" }
end

return M
