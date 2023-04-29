-- Create key bindings that stick. WhichKey is a lua plugin for Neovim 0.5 that displays
-- a popup with possible keybindings of the command you started typing.
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    defaults = {
      mode = { "n", "v" },
      -- ["g"] = { name = "+goto" },
      -- ["gz"] = { name = "+surround" },
      ["]"] = { name = "+next" },
      ["["] = { name = "+prev" },
      ["<Space><tab>"] = { name = "+tabs" },
      ["<Space>b"] = { name = "+buffer" },
      ["<Space>c"] = { name = "+code" },
      ["<Space>d"] = { name = "+debug" },
      ["<Space>da"] = { name = "+adaptor" },
      ["<Space>f"] = { name = "+file/find" },
      ["<Space>g"] = { name = "+git" },
      ["<Space>h"] = { name = "+hunks" },
      ["<Space>q"] = { name = "+quit/session" },
      ["<Space>s"] = { name = "+search" },
      ["<Space>u"] = { name = "+ui" },
      -- ["<Space>w"] = { name = "+windows" },
      ["<Space>x"] = { name = "+diagnostics/quickfix" },
    },
  },
  config = function(_, opts)
    local wk = require "which-key"
    wk.setup(opts)
    wk.register(opts.defaults)
  end,
}
