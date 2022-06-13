-- [git-messenger.vim](https://github.com/rhysd/git-messenger.vim)
--
-- Vim and Neovim plugin to reveal the commit messages under the cursor.
--
return {
  "rhysd/git-messenger.vim",
  cmd = { "GitMessenger" },
  keys = {
    { "n", "<Plug>(git-messenger" },
  },
  setup = function()
    vim.g.git_messenger_no_default_mappings = true
    vim.keymap.set("n", "<Space>gm", "<Plug>(git-messenger)", { silent = true })
  end,
}
