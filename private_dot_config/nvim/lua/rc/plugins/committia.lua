return {
  -- A Vim plugin for more pleasant editing on commit messages
  "rhysd/committia.vim",
  ft = { "gitcommit" },
  init = function()
    vim.g.committia_min_window_width = 100
  end,
}
