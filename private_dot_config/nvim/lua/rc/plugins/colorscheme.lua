local transparent = vim.fn.exists "g:GuiLoaded" == 0 and vim.fn.has "gui" == 0 and vim.fn.exists "$SSH_CONNECTION" == 0

return {
  -- kanagawa
  {
    "rebelot/kanagawa.nvim",
    build = ":KanagawaCompile",
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
    name = "catppuccin",
    lazy = true,
    opts = {
      flavour = "mocha",
      background = {
        light = "latte",
        dark = "mocha",
      },
      transparent_background = transparent,
      integrations = {
        cmp = true,
        gitsigns = true,
        telescope = true,
        notify = true,
        mini = true,
        indent_blankline = {
          enabled = true,
          colored_indent_levels = false,
        },
        navic = {
          enabled = true,
          custom_bg = "NONE",
        },
      },
    },
  },
}
