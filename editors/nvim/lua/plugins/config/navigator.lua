local M = {}

function M.config()
  require("Navigator").setup()
  local nnoremap = vim.keymap.nnoremap

  nnoremap { "<M-h>", "<cmd>lua require('Navigator').left()<CR>", silent = true }
  nnoremap { "<M-j>", "<cmd>lua require('Navigator').down()<CR>", silent = true }
  nnoremap { "<M-k>", "<cmd>lua require('Navigator').up()<CR>", silent = true }
  nnoremap { "<M-l>", "<cmd>lua require('Navigator').right()<CR>",
             silent = true }
  nnoremap {
    "<M-\\>",
    "<cmd>lua require('Navigator').previous()<CR>",
    silent = true,
  }
end

return M
