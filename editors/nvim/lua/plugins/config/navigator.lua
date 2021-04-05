local M = {}

function M.config()
  require("Navigator").setup()
  local map = vim.api.nvim_set_keymap
  local opts = { noremap = true, silent = true }

  map("n", "<M-h>", "<cmd>lua require('Navigator').left()<CR>", opts)
  map("n", "<M-j>", "<cmd>lua require('Navigator').down()<CR>", opts)
  map("n", "<M-k>", "<cmd>lua require('Navigator').up()<CR>", opts)
  map("n", "<M-l>", "<cmd>lua require('Navigator').right()<CR>", opts)
  map("n", "<M-\\>", "<cmd>lua require('Navigator').previous()<CR>", opts)
end

return M
