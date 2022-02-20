local M = {}

function M.setup()
  vim.keymap.set({ "n", "x", "o" }, "f", "<Plug>(eft-f-repeatable)")
  vim.keymap.set({ "n", "x", "o" }, "F", "<Plug>(eft-F-repeatable)")
  vim.keymap.set({ "n", "x", "o" }, "t", "<Plug>(eft-t-repeatable)")
  vim.keymap.set({ "n", "x", "o" }, "T", "<Plug>(eft-T-repeatable)")
end

return M
