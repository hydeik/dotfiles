return {
  -- Colorscheme: catppuccin
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  opts = {
    flavour = "auto",
    background = {
      light = "latte",
      dark = "mocha",
    },
    transparent_background = true,
    -- sets terminal colors (e.g. `g:terminal_color_0`)
    term_colors = true,
    -- Handles the style of specific lsp hl groups (see `:h lsp-highlight`).
    lsp_styles = {
      underlines = {
        errors = { "undercurl" },
        hints = { "undercurl" },
        warnings = { "undercurl" },
        information = { "undercurl" },
      },
    },
    default_integrations = false,
    -- If you use lazy.nvim as your package manager, you can use the auto_integrations option
    -- to let catppuccin automatically detect installed plugins and enable their respective integrations.
    auto_integrations = true,
  },
}
