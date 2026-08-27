local transparent = vim.fn.exists "g:GuiLoaded" == 0 and vim.fn.has "gui" == 0 and vim.fn.exists "$SSH_CONNECTION" == 0

return {
  -- kanagawa
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
}
