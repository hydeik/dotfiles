local M = {}

function M.setup()
  vim.keymap.set("n", "<Space>gy", "<Cmd>lua require'gitlinker'.get_buf_range_url('n')<CR>", { silent = true })
  vim.keymap.set("v", "<Space>gy", "<Cmd>lua require'gitlinker'.get_buf_range_url('n')<CR>")
  vim.keymap.set("n", "<Space>gY", "<Cmd>lua require'gitlinker'.get_repo_url()<CR>")
  vim.keymap.set(
    "n",
    "<Space>gB",
    "<Cmd>lua require'gitlinker'.get_repo_url({action_callback = require'gitlinker.actions'.open_in_browser})<CR>"
  )
end

function M.config()
  require("gitlinker").setup {
    mappings = nil,
  }
end

return M
