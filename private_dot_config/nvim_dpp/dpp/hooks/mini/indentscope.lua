--- [mini.indentscope](https://github.com/echasnovski/mini.indentscope)
-- Neovim Lua plugin to visualize and operate on indent scope.
-- Part of 'mini.nvim' library.

-- lua_add {{{
vim.api.nvim_create_autocmd("FileType", {
  group = require("rc.bootstrap").rc_autocmds,
  pattern = {
    "alpha",
    "dashboard",
    "fzf",
    "help",
    "lazy",
    "lazyterm",
    "mason",
    "neo-tree",
    "notify",
    "toggleterm",
    "Trouble",
    "trouble",
  },
  callback = function()
    vim.b.miniindentscope_disable = true
  end,
})
-- }}}

-- lua_source {{{
require("mini.indentscope").setup {
  symbol = "│",
  options = { try_as_border = true },
}
-- }}}
