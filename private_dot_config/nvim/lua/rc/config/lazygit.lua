local M = {}

function M.setup()
  vim.g.lazygit_floating_window_winblend = 0
  vim.g.lazygit_floating_window_scaling_factor = 0.9
  vim.g.lazygit_floating_window_corner_chars = { "╭", "╮", "╰", "╯" }
  vim.g.lazygit_use_neovim_remote = 0
  vim.keymap.set("n", "<Space>gl", "<Cmd>LazyGit<CR>", { silent = true })
end

return M
