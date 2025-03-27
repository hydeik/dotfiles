return {
  -- Colorscheme: catppuccin
  "catppuccin/nvim",
  lazy = true,
  name = "catppuccin",
  opts = {
    flavour = "mocha",
    background = {
      light = "latte",
      dark = "mocha",
    },
    integrations = {
      alpha = false,
      cmp = true,
      dashboard = true,
      flash = true,
      gitsigns = true,
      illuminate = true,
      indent_blankline = {
        enabled = true,
        colored_indent_levels = false,
      },
      leap = false,
      lsp_trouble = true,
      mason = false,
      markdown = true,
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
        custom_bg = "lualine",
      },
      neotest = true,
      neotree = true,
      noice = true,
      notify = true,
      snacks = {
        enabled = true,
        indent_scope_color = "", -- catppuccin color (eg. `lavender`) Default: text
      },
      telescope = {
        enable = true,
      },
      treesitter = true,
      treesitter_context = true,
      which_key = true,
    },
  },
}
