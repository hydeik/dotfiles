local M = {}

function M.setup()
  local opts = { silent = true, nowait = true }
  vim.keymap.set("n", "<M-h>", "<Cmd>lua require('tmux').move_left()<CR>", opts)
  vim.keymap.set("n", "<M-j>", "<Cmd>lua require('tmux').move_bottom()<CR>", opts)
  vim.keymap.set("n", "<M-k>", "<Cmd>lua require('tmux').move_top()<CR>", opts)
  vim.keymap.set("n", "<M-l>", "<Cmd>lua require('tmux').move_right()<CR>", opts)

  vim.keymap.set("n", "<C-M-h>", "<Cmd>lua require('tmux').resize_left()<CR>", opts)
  vim.keymap.set("n", "<C-M-j>", "<Cmd>lua require('tmux').resize_bottom()<CR>", opts)
  vim.keymap.set("n", "<C-M-k>", "<Cmd>lua require('tmux').resize_top()<CR>", opts)
  vim.keymap.set("n", "<C-M-l>", "<Cmd>lua require('tmux').resize_right()<CR>", opts)
end

function M.config()
  require("tmux").setup {
    navigation = {
      enable_default_keybindings = false,
    },
    resize = {
      enable_default_keybindings = false,
      resize_step_x = 2,
      resize_step_y = 2,
    },
  }
end

return M
