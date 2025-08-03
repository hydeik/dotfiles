return {
  --- A collection of small QoL plugins for Neovim.
  -- NOTE: A couple of plugins require snacks.nvim to be set-up early.
  --       Setup creates some autocmds and does not load any plugins.
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {},
  config = function(_, opts)
    local notify = vim.notify
    require("snacks").setup(opts)
    -- HACK: restore vim.notify after snacks setup and let noice.nvim take over
    -- this is needed to have early notifications show up in noice history
    if require("rc.utils.lazy").has_plugin "noice.nvim" then
      vim.notify = notify
    end
  end,
}
