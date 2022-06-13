-- [nvim-web-devicons](https://github.com/kyazdani42/nvim-web-devicons)
--
-- A lua fork of vim-devicons. This plugin provides the same icons as well as colors for each icon.
--
return {
  "kyazdani42/nvim-web-devicons",
  module = "nvim-web-devicons",
  config = function()
    require("nvim-web-devicons").setup {
      -- Your personnal icons can go here (to override).
      -- You can specify color or cterm_color instead of specifying both of them
      -- DevIcon will be appended to `name`
      -- override = {
      --   zsh = {
      --     icon = "",
      --     color = "#428850",
      --     cterm_color = "65",
      --     name = "Zsh"
      --   }
      -- };
      -- globally enable default icons (default to false)
      -- will get overriden by `get_icons` option
      default = true,
    }
  end,
}
