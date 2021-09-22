local M = {}

function M.setup()
  vim.keymap.nmap { "f", "<Plug>(eft-f-repeatable)" }
  vim.keymap.xmap { "f", "<Plug>(eft-f-repeatable)" }
  vim.keymap.omap { "f", "<Plug>(eft-f-repeatable)" }
  vim.keymap.nmap { "F", "<Plug>(eft-F-repeatable)" }
  vim.keymap.xmap { "F", "<Plug>(eft-F-repeatable)" }
  vim.keymap.omap { "F", "<Plug>(eft-F-repeatable)" }
  vim.keymap.nmap { "t", "<Plug>(eft-t-repeatable)" }
  vim.keymap.xmap { "t", "<Plug>(eft-t-repeatable)" }
  vim.keymap.omap { "t", "<Plug>(eft-t-repeatable)" }
  vim.keymap.nmap { "T", "<Plug>(eft-T-repeatable)" }
  vim.keymap.xmap { "T", "<Plug>(eft-T-repeatable)" }
  vim.keymap.omap { "T", "<Plug>(eft-T-repeatable)" }
end

return M
