local M = {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 999,
}

M.config = function()
  local transparent = vim.fn.exists "g:GuiLoaded" == 0
    and vim.fn.has "gui" == 0
    and vim.fn.exists "$SSH_CONNECTION" == 0

  require("catppuccin").setup {
    flavour = "mocha",
    background = {
      light = "latte",
      dark = "mocha",
    },
    transparent_background = transparent,
    -- custom_highlights = function(colors)
    --   return {
    --     NotifyBackgroud = { fg = colors.text, bg = colors.base },
    --     NotifyERRORBody = { link = "NotifyBackgroud" },
    --     NotifyWARNBody = { link = "NotifyBackgroud" },
    --     NotifyINFOBody = { link = "NotifyBackgroud" },
    --     NotifyTRACEBody = { link = "NotifyBackgroud" },
    --   }
    -- end,
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
  }

  vim.cmd.colorscheme "catppuccin"
end

return M
