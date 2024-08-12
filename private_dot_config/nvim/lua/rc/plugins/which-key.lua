-- Create key bindings that stick. WhichKey is a lua plugin for Neovim 0.5 that displays
-- a popup with possible keybindings of the command you started typing.
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts_extend = { "spec" },
  opts = {
    defaults = {},
    spec = {
      mode = { "n", "v" },
      { "<Space><tab>", group = "tabs" },
      { "<Space>c", group = "code" },
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
  config = function(_, opts)
    require("which-key").setup(opts)
  end,
}
