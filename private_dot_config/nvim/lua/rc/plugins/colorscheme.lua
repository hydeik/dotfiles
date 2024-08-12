local transparent = vim.fn.exists "g:GuiLoaded" == 0 and vim.fn.has "gui" == 0 and vim.fn.exists "$SSH_CONNECTION" == 0

return {
  -- kanagawa
  {
    "rebelot/kanagawa.nvim",
    build = ":KanagawaCompile",
    lazy = true,
    opts = {
      compile = true,
      dimInactive = true,
      globalStatus = true,
      transparent = transparent,
      theme = "wave",
      background = {
        dark = "dragon",
        light = "lotus",
      },
      overrides = function(colors)
        local theme = colors.theme
        return transparent
            and {
              NormalFloat = { bg = "none" },
              FloatBorder = { bg = "none" },
              FloatTitle = { bg = "none" },
              NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
              LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
              MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
            }
          or {}
      end,
    },
  },
  -- catppuccin
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    opts = {
      flavour = "mocha",
      background = {
        light = "latte",
        dark = "mocha",
      },
      transparent_background = transparent,
      integrations = {
        cmp = true,
        dashboard = true,
        flash = true,
        gitsigns = true,
        illuminate = true,
        indent_blankline = {
          enabled = true,
          colored_indent_levels = false,
        },
        leap = true,
        lsp_trouble = true,
        mason = true,
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
          custom_bg = "NONE",
        },
        noice = true,
        notify = true,
        telescope = {
          enable = true,
        },
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
    },
  },
}
