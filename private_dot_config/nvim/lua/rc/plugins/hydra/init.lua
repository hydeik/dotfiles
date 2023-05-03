-- Create custom submodes and menus
return {
  enabled = false,
  "anuvyklack/hydra.nvim",
  dependencies = {
    "lewis6991/gitsigns.nvim",
    "mrjones2014/smart-splits.nvim",
    "sindrets/winshift.nvim",
  },
  keys = {
    { "z", mode = "n" },
    { "<C-w>", mode = "n" },
    { "<Space>o", mode = { "n", "x" } },
    { "<Space>g", mode = { "n", "x" } },
  },
  config = function()
    require "rc.plugins.hydra.git"
    require "rc.plugins.hydra.options"
    require "rc.plugins.hydra.windows"
  end,
}
