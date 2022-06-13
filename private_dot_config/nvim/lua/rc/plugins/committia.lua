-- [committia.vim](https://github.com/rhysd/committia.vim)
--
-- A Vim plugin for more pleasant editing on commit messages
--
return {
  "rhysd/committia.vim",
  ft = { "gitcommit" },
  setup = function()
    vim.g.committia_min_window_width = 100
  end,
}
