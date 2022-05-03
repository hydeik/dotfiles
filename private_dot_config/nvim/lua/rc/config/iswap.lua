local M = {}

function M.config()
  vim.keymap.set("n", "<Leader>s", "<Cmd>ISwapWith<CR>", { silent = true })
end

return M
