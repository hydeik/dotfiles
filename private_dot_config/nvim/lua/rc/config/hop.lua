local M = {}

function M.setup()
  vim.keymap.set({ "n", "x", "o" }, "ss", "<Cmd>lua require'hop'.hint_char2()<CR>")
  vim.keymap.set({ "n", "x", "o" }, "sl", "<Cmd>lua require'hop'.hint_lines()<CR>")
  vim.keymap.set({ "n", "x", "o" }, "s/", "<Cmd>lua require'hop'.hint_patterns()<CR>")
end

function M.config()
  require("hop").setup()
end

return M
