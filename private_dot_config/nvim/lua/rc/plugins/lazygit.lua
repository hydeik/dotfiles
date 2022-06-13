-- [lazygit.nvim](https://github.com/kdheepak/lazygit.nvim)
--
-- Plugin for calling LazyGit from within neovim
--
return {
  "kdheepak/lazygit.nvim",
  cmd = { "LazyGit", "LazyGitFilter", "LazyGitConfig" },
  setup = function()
    vim.g.lazygit_floating_window_winblend = 0
    vim.g.lazygit_floating_window_scaling_factor = 0.9
    vim.g.lazygit_floating_window_corner_chars = { "╭", "╮", "╰", "╯" }
    vim.g.lazygit_use_neovim_remote = 0
    vim.keymap.set("n", "<Space>gl", "<Cmd>LazyGit<CR>", { silent = true })
  end,
}
