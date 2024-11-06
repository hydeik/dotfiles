--- [nvim-navic](https://github.com/SmiteshP/nvim-navic)
--- Simple winbar/statusline plugin that shows your current code context

-- lua_add {{{
vim.g.navic_silence = true
-- }}}

-- lua_source {{{

require("nvim-navic").setup {
  -- icons = icons,
  icons = require("mini.icons").list "lsp",
  lsp = {
    auto_attach = true,
  },
  separator = " > ",
  highlight = true,
  depth_limit = 5,
}

-- }}}
