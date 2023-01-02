-- A lua neovim plugin to generate shareable file permalinks (with line ranges)
-- for several git web frontend hosts. Inspired by tpope/vim-fugitive's :GBrowse
local M = {
  "ruifm/gitlinker.nvim",
}

M.init = function()
  vim.keymap.set(
    "n",
    "<Space>gy",
    "<Cmd>lua require'gitlinker'.get_buf_range_url('n')<CR>",
    { silent = true, desc = "[Git] Bufer URL" }
  )
  vim.keymap.set(
    "v",
    "<Space>gy",
    "<Cmd>lua require'gitlinker'.get_buf_range_url('n')<CR>",
    { desc = "[Git] Bufer URL" }
  )
  vim.keymap.set(
    "n",
    "<Space>gY",
    "<Cmd>lua require'gitlinker'.get_repo_url()<CR>",
    { silent = true, desc = "[Git] Repo URL" }
  )
  vim.keymap.set(
    "n",
    "<Space>gB",
    "<Cmd>lua require'gitlinker'.get_repo_url({action_callback = require'gitlinker.actions'.open_in_browser})<CR>",
    { silent = true, desc = "[Git] Open in Browser" }
  )
end

M.config = function()
  require("gitlinker").setup {
    mappings = nil,
  }
end

return M
