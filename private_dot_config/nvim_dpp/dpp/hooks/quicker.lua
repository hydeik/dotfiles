--- [quicker.nvim](https://github.com/stevearc/quicker.nvim)
--- Improved UI and workflow for the Neovim quickfix

-- lua_add {{{
vim.keymap.set("n", "<Space>xQ", function()
  require("quicker").toggle()
end, {
  desc = "Toggle quickfix",
})

vim.keymap.set("n", "<leader>xL", function()
  require("quicker").toggle { loclist = true }
end, {
  desc = "Toggle loclist",
})

-- }}}

-- lua_source {{{
local icons = require "rc.custom_icons"
require("quicker").setup {
  keys = {
    {
      ">",
      function()
        require("quicker").expand { before = 2, after = 2, add_to_existing = true }
      end,
      desc = "Expand quickfix context",
    },
    {
      "<",
      function()
        require("quicker").collapse()
      end,
      desc = "Collapse quickfix context",
    },
  },
  type_icons = {
    E = icons.diagnostics.Error,
    W = icons.diagnostics.Warn,
    I = icons.diagnostics.Info,
    N = icons.diagnostics.Hint,
    H = icons.diagnostics.Hint,
  },
}

-- }}}
