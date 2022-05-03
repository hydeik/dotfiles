local M = {}

function M.setup()
  vim.g.miniyank_maxitems = 100
  vim.keymap.set("n", "p", "<Plug>(miniyank-autoput)")
  vim.keymap.set("n", "P", "<Plug>(miniyank-autoPut)")
end

return M
