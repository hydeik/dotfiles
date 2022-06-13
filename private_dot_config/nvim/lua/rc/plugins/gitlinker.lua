-- [gitlinker.nvim](https://github.com/ruifm/gitlinker.nvim)
--
-- A lua neovim plugin to generate shareable file permalinks (with line ranges) for several git web frontend hosts.
-- Inspired by tpope/vim-fugitive's :GBrowse
--
return {
  "ruifm/gitlinker.nvim",
  requires = { "plenary.nvim" },
  module = { "gitlinker" },
  setup = function()
    vim.keymap.set("n", "<Space>gy", "<Cmd>lua require'gitlinker'.get_buf_range_url('n')<CR>", { silent = true })
    vim.keymap.set("v", "<Space>gy", "<Cmd>lua require'gitlinker'.get_buf_range_url('n')<CR>")
    vim.keymap.set("n", "<Space>gY", "<Cmd>lua require'gitlinker'.get_repo_url()<CR>")
    vim.keymap.set(
      "n",
      "<Space>gB",
      "<Cmd>lua require'gitlinker'.get_repo_url({action_callback = require'gitlinker.actions'.open_in_browser})<CR>"
    )
  end,
  config = function()
    require("gitlinker").setup {
      mappings = nil,
    }
  end,
}
