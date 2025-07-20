return {
  {
    "snacks.nvim",
    opts = {
      bigfile = { enabled = true },
      lazygit = { enabled = true, configure = false },
      rename = { enabled = true },
      quickfile = { enabled = true },
      scratch = { enabled = true },
      terminal = {
        enabled = true,
        -- win = {
        --   keys = {
        --     nav_h = { "<C-h>", term_nav("h"), desc = "Go to Left Window", expr = true, mode = "t" },
        --     nav_j = { "<C-j>", term_nav("j"), desc = "Go to Lower Window", expr = true, mode = "t" },
        --     nav_k = { "<C-k>", term_nav("k"), desc = "Go to Upper Window", expr = true, mode = "t" },
        --     nav_l = { "<C-l>", term_nav("l"), desc = "Go to Right Window", expr = true, mode = "t" },
        --   },
        -- },
      },
    },
    keys = {
      {
        "<Space>gg",
        function()
          ---@diagnostic disable-next-line: missing-fields
          Snacks.lazygit { cwd = require("rc.utils").find_git_root() }
        end,
        desc = "Lazygit (Root dir)",
      },
      {
        "<Space>gG",
        function()
          Snacks.lazygit()
        end,
        desc = "Lazygit (cwd)",
      },
      {
        "<Space>.",
        function()
          Snacks.scratch()
        end,
        desc = "Toggle Scratch Buffer",
      },
      {
        "<Space>S",
        function()
          Snacks.scratch.select()
        end,
        desc = "Select Scratch Buffer",
      },
      {
        "<Space>dps",
        function()
          Snacks.profiler.scratch()
        end,
        desc = "Profiler Scratch Buffer",
      },
      {
        "<Space>ft",
        function()
          Snacks.terminal()
        end,
        desc = "Terminal (cwd)",
      },
      {
        "<Space>fT",
        function()
          Snacks.terminal(nil, { cwd = require("rc.utils").find_root() })
        end,
        desc = "Terminal (Root Dir)",
      },
      {
        "<C-/>",
        function()
          Snacks.terminal(nil, { cwd = require("rc.utils").find_root() })
        end,
        desc = "Terminal (Root Dir)",
      },
      {
        "<C-_>",
        function()
          Snacks.terminal(nil, { cwd = require("rc.utils").find_root() })
        end,
        desc = "which_key_ignore",
      },
    },
  },
}
