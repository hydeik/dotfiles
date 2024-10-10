--- [nvim-notify](https://github.com/rcarriga/nvim-notify)
-- A fancy, configurable, notification manager for NeoVim

-- lua_add {{{
vim.keymap.set("n", "<Space>un", function()
  require("notify").dismiss { silent = true, pending = true }
end, { desc = "Dismiss all notifications" })
-- }}}

-- lua_source {{{
require("notify").setup {
  stages = "static",
  timeout = 2000,
  max_height = function()
    return math.floor(vim.o.lines * 0.75)
  end,
  max_width = function()
    return math.floor(vim.o.columns * 0.75)
  end,
}
-- }}}
