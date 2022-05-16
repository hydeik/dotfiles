local M = {}

function M.config()
  vim.keymap.set("n", "<Leader>s", "<Cmd>ISwap<CR>", { silent = true })
  vim.keymap.set("n", "<Leader>S", "<Cmd>ISwapWith<CR>", { silent = true })
end

return M
