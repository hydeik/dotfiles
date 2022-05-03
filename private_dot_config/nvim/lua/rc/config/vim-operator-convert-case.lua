local M = {}

function M.setup()
  vim.keymap.set("n", "~", "<Plug>(operator-convert-case-loop)")
  vim.keymap.set("x", "~", "<Plug>(operator-convert-case-loop)gv")
end

return M
