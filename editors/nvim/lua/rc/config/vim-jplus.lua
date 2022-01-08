local M = {}

function M.setup()
  vim.keymap.set({ "n", "v" }, "J", "<Plug>(jplus)")
  vim.keymap.set({ "n", "v" }, "<Leader>J", "<Plug>(jplus-input)")
end

return M
