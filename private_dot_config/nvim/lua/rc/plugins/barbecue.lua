return {
  "utilyre/barbecue.nvim",
  enabled = false,
  version = "*",
  event = "VeryLazy",
  dependencies = {
    {
      "SmiteshP/nvim-navic",
      opts = {
        lsp = { auto_attach = true },
      },
    },
    { "nvim-tree/nvim-web-devicons" }, -- optional dependency
  },
  opts = {
    -- configurations go here
    attach_navic = false,
    kinds = require("rc.core.config").icons.kinds,
  },
}
