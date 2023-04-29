local transparent = vim.fn.exists "g:GuiLoaded" == 0 and vim.fn.has "gui" == 0 and vim.fn.exists "$SSH_CONNECTION" == 0

return {
  -- kanagawa
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      dimInactive = true,
      globalStatus = true,
      transparent = transparent,
      theme = "default",
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
    config = function(_, opts)
      require("kanagawa").setup(opts)
      vim.api.nvim_set_hl(0, "NavicIconsFile", { link = "Directory" })
      vim.api.nvim_set_hl(0, "NavicIconsModule", { link = "@include" })
      vim.api.nvim_set_hl(0, "NavicIconsNamespace", { link = "@namespace" })
      vim.api.nvim_set_hl(0, "NavicIconsPackage", { link = "@include" })
      vim.api.nvim_set_hl(0, "NavicIconsClass", { link = "@structure" })
      vim.api.nvim_set_hl(0, "NavicIconsMethod", { link = "@method" })
      vim.api.nvim_set_hl(0, "NavicIconsProperty", { link = "@property" })
      vim.api.nvim_set_hl(0, "NavicIconsField", { link = "@field" })
      vim.api.nvim_set_hl(0, "NavicIconsConstructor", { link = "@constructor" })
      vim.api.nvim_set_hl(0, "NavicIconsEnum", { link = "@field" })
      vim.api.nvim_set_hl(0, "NavicIconsInterface", { link = "@type" })
      vim.api.nvim_set_hl(0, "NavicIconsFunction", { link = "@function" })
      vim.api.nvim_set_hl(0, "NavicIconsVariable", { link = "@variable" })
      vim.api.nvim_set_hl(0, "NavicIconsConstant", { link = "@constant" })
      vim.api.nvim_set_hl(0, "NavicIconsString", { link = "@string" })
      vim.api.nvim_set_hl(0, "NavicIconsNumber", { link = "@number" })
      vim.api.nvim_set_hl(0, "NavicIconsBoolean", { link = "@boolean" })
      vim.api.nvim_set_hl(0, "NavicIconsArray", { link = "@field" })
      vim.api.nvim_set_hl(0, "NavicIconsObject", { link = "@type" })
      vim.api.nvim_set_hl(0, "NavicIconsKey", { link = "@keyword" })
      vim.api.nvim_set_hl(0, "NavicIconsNull", { link = "@comment" })
      vim.api.nvim_set_hl(0, "NavicIconsEnumMember", { link = "@field" })
      vim.api.nvim_set_hl(0, "NavicIconsStruct", { link = "@structure" })
      vim.api.nvim_set_hl(0, "NavicIconsEvent", { link = "@keyword" })
      vim.api.nvim_set_hl(0, "NavicIconsOperator", { link = "@operator" })
      vim.api.nvim_set_hl(0, "NavicIconsTypeParameter", { link = "@type" })
    end,
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
