local M = {}

function M.config()
  require("mini.trailspace").setup()
  vim.keymap.set("n", "<Leader>x", "<Cmd>lua MiniTrailspace.trim()<CR>", { silent = true })
end

return M
