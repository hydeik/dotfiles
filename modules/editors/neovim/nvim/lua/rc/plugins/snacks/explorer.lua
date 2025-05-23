return {
  "folke/snacks.nvim",
  opts = { explorer = {} },
  keys = {
    {
      "<Space>fe",
      function()
        Snacks.explorer { cwd = require("rc.utils").find_root() }
      end,
      desc = "Explorer Snacks (root dir)",
    },
    {
      "<Space>fE",
      function()
        Snacks.explorer()
      end,
      desc = "Explorer Snacks (cwd)",
    },
    { "<leader>e", "<leader>fe", desc = "Explorer Snacks (root dir)", remap = true },
    { "<leader>E", "<leader>fE", desc = "Explorer Snacks (cwd)", remap = true },
  },
}
