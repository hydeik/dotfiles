local M = {}

function M.setup()
  vim.keymap.set({ "n", "v" }, "<C-a>", "<Plug>(dial-increment)")
  vim.keymap.set({ "n", "v" }, "<C-x>", "<Plug>(dial-decrement)")
  vim.keymap.set("v", "g<C-a>", "<Plug>(dial-increment-additional)")
  vim.keymap.set("v", "g<C-x>", "<Plug>(dial-decrement-additional)")
end

return M
