return {
  -- A lua neovim plugin to generate shareable file permalinks (with line ranges)
  -- for several git web frontend hosts. Inspired by tpope/vim-fugitive's :GBrowse
  "ruifm/gitlinker.nvim",
  keys = {
    {
      "<Space>gy",
      "<Cmd>lua require'gitlinker'.get_buf_range_url('n')<CR>",
      silent = true,
      desc = "[Git] Buffer URL",
    },
    {
      "<Space>gy",
      "<Cmd>lua require'gitlinker'.get_buf_range_url('n')<CR>",
      mode = "v",
      desc = "[Git] Buffer URL",
    },
    {
      "<Space>gY",
      "<Cmd>lua require'gitlinker'.get_repo_url()<CR>",
      silent = true,
      desc = "[Git] Repo URL",
    },
    {
      "<Space>gB",
      "<Cmd>lua require'gitlinker'.get_repo_url({action_callback = require'gitlinker.actions'.open_in_browser})<CR>",
      silent = true,
      desc = "[Git] Open in Browser",
    },
  },
  opts = {
    mappings = nil,
  },
}
