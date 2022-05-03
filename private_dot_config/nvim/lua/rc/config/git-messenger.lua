local M = {}

function M.setup()
  vim.g.git_messenger_no_default_mappings = true
  vim.keymap.set("n", "<Space>gm", "<Plug>(git-messenger)", { silent = true })
end

return M
