--- [crates.nvim](https://github.com/saecki/crates.nvim)
--- A neovim plugin that helps managing crates.io dependencies

-- lua_source {{{
require("crates").setup {
  completion = {
    crates = {
      enabled = true,
    },
  },
  lsp = {
    enabled = true,
    actions = true,
    completion = true,
    hover = true,
  },
}
-- }}}
