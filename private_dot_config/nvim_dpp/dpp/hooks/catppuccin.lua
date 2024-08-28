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
    cmp = false,
    gitsigns = true,
    illuminate = true,
    indent_blankline = {
      enabled = true,
      colored_indent_levels = false,
    },
    lsp_trouble = true,
    mini = {
      enabled = true,
      indentscope_color = "", -- catppuccin color (eg. `lavender`) Default: text
    },
    native_lsp = {
      enabled = true,
      underline = {
        errors = { "undercurl" },
        hints = { "undercurl" },
        warnings = { "undercurl" },
        information = { "undercurl" },
      },
    },
    navic = {
      enabled = true,
      custom_bg = "NONE",
    },
    noice = true,
    notify = true,
    telescope = {
      enable = false,
    },
    treesitter = true,
    treesitter_context = true,
    which_key = true,
  },
}

vim.cmd.colorscheme "catppuccin"

-- }}}
