-- Smart, directional Neovim and tmux split resizing and navigation.
-- Think about splits in terms of "up/down/left/right".
local M = {
  "mrjones2014/smart-splits.nvim",
}

M.init = function()
  -- moving between splits
  vim.keymap.set("n", "<M-h>", require("smart-splits").move_cursor_left, { desc = "Move Window Left" })
  vim.keymap.set("n", "<M-j>", require("smart-splits").move_cursor_down, { desc = "Move Window Down" })
  vim.keymap.set("n", "<M-k>", require("smart-splits").move_cursor_up, { desc = "Move Window Up" })
  vim.keymap.set("n", "<M-l>", require("smart-splits").move_cursor_right, { desc = "Move Window Right" })
  -- resize splits
  vim.keymap.set("n", "<C-M-h>", require("smart-splits").resize_left, { desc = "Resize Window Left" })
  vim.keymap.set("n", "<C-M-j>", require("smart-splits").resize_down, { desc = "Resize Window Left" })
  vim.keymap.set("n", "<C-M-k>", require("smart-splits").resize_up, { desc = "Resize Window Left" })
  vim.keymap.set("n", "<C-M-l>", require("smart-splits").resize_right, { desc = "Resize Window Left" })
end

return M
