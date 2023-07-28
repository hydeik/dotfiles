return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  keys = {
    {
      "<Space>fe",
      function()
        local dir = require("rc.util").get_root()
        require("oil").open_float(dir)
      end,
      desc = "Open oil (root dir)",
    },
    {
      "<Space>fE",
      function()
        local dir = vim.uv.cwd()
        require("oil").open_float(dir)
      end,
      desc = "Open oil (cwd)",
    },
  },
  opts = function()
    local trash_cmd = "rip"
    local has_trash = vim.fn.executable(trash_cmd)

    return {
      delete_to_trash = has_trash,
      trash_command = trash_cmd,
      view_options = {
        show_hidden = true,
      },
    }
  end,
}
