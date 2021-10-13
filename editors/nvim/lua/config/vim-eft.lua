local M = {}

function M.setup()
  local keymap = require "rc.core.keymap"
  keymap.nmap { "f", "<Plug>(eft-f-repeatable)" }
  keymap.xmap { "f", "<Plug>(eft-f-repeatable)" }
  keymap.omap { "f", "<Plug>(eft-f-repeatable)" }
  keymap.nmap { "F", "<Plug>(eft-F-repeatable)" }
  keymap.xmap { "F", "<Plug>(eft-F-repeatable)" }
  keymap.omap { "F", "<Plug>(eft-F-repeatable)" }
  keymap.nmap { "t", "<Plug>(eft-t-repeatable)" }
  keymap.xmap { "t", "<Plug>(eft-t-repeatable)" }
  keymap.omap { "t", "<Plug>(eft-t-repeatable)" }
  keymap.nmap { "T", "<Plug>(eft-T-repeatable)" }
  keymap.xmap { "T", "<Plug>(eft-T-repeatable)" }
  keymap.omap { "T", "<Plug>(eft-T-repeatable)" }
end

return M
