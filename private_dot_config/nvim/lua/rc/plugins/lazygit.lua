-- Plugin for calling lazygit from within neovim.
return {
  "kdheepak/lazygit.nvim",
  cmd = { "LazyGit", "LazyGitFilter", "LazyGitConfig" },
  keys = {
    { "<Space>gl", "<cmd>LazyGit<CR>", silent = true, desc = "Launch LazyGit" },
  },
  init = function()
    vim.g.lazygit_floating_window_winblend = 0
    vim.g.lazygit_floating_window_scaling_factor = 0.9
    vim.g.lazygit_floating_window_corner_chars = { "╭", "╮", "╰", "╯" }
    vim.g.lazygit_use_neovim_remote = 0
  end,
}
