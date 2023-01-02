-- A super powerful autopair plugin for Neovim that supports multiple characters.
return {
  "windwp/nvim-autopairs",
  config = function()
    require("nvim-autopairs").setup {
      disabled_filetype = { "TelescopePrompt" },
      map_cr = false,
    }
  end,
}
