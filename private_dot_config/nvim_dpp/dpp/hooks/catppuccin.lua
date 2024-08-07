-- lua_add {{{

local transparent = vim.fn.exists "g:GuiLoaded" == 0 and vim.fn.has "gui" == 0 and vim.fn.exists "$SSH_CONNECTION" == 0

require("catppuccin").setup {
  flavour = "mocha",
  background = {
    light = "latte",
    dark = "mocha",
  },
  transparent_background = transparent,
  integrations = {
    cmp = true,
    gitsigns = true,
    indent_blankline = {
      enabled = true,
      scope_color = "", -- catppuccin color (eg. `lavender`) Default: text
      colored_indent_levels = false,
    },
    lsp_trouble = true,
    mini = {
      enabled = true,
      indentscope_color = "", -- catppuccin color (eg. `lavender`) Default: text
    },
    noice = true,
    notify = true,
    telescope = true,
    which_key = true,
  },
}

vim.cmd.colorscheme "catppuccin"

-- }}}
