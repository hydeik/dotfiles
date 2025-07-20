return {
  -- Create key bindings that stick. WhichKey is a lua plugin for Neovim 0.5 that displays
  -- a popup with possible keybindings of the command you started typing.
  "folke/which-key.nvim",
  lazy = true,
  event = "VeryLazy",
  opts_extend = { "spec" },
  opts = {
    preset = "helix",
    defaults = {},
    spec = {
      mode = { "n", "v" },
      { "<Space><tab>", group = "tabs" },
      { "<Space>c", group = "code" },
      { "<Space>d", group = "debug" },
      { "<Space>dp", group = "profiler" },
      { "<Space>f", group = "file/find" },
      { "<Space>g", group = "git" },
      { "<Space>h", group = "hunks" },
      { "<Space>q", group = "quit/session" },
      { "<Space>s", group = "search" },
      { "<Space>u", group = "ui", icon = { icon = "󰙵 ", color = "cyan" } },
      { "<Space>x", group = "diagnostics/quickfix", icon = { icon = "󱖫 ", color = "green" } },
      { "[", group = "prev" },
      { "]", group = "next" },
      { "g", group = "goto" },
      { "gs", group = "surround" },
      { "z", group = "fold" },
      {
        "<Space>b",
        group = "buffer",
        expand = function()
          return require("which-key.extras").expand.buf()
        end,
      },
      {
        "<Space>w",
        group = "windows",
        proxy = "<c-w>",
        expand = function()
          return require("which-key.extras").expand.win()
        end,
      },
      -- better descriptions
      { "gx", desc = "Open with system app" },
    },
  },
  keys = {
    {
      "<Space>?",
      function()
        require("which-key").show { global = false }
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
    {
      "<c-w><space>",
      function()
        require("which-key").show { keys = "<c-w>", loop = true }
      end,
      desc = "Window Hydra Mode (which-key)",
    },
  },
}
