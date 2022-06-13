-- [nvim-autopairs](https://github.com/windwp/nvim-autopairs)
--
-- A super powerful autopair plugin for Neovim that supports multiple characters.
--
return {
  "windwp/nvim-autopairs",
  module = { "nvim-autopairs" },
  event = { "InsertEnter" },
  config = function()
    require("nvim-autopairs").setup {
      disabled_filetype = { "TelescopePrompt" },
      map_cr = false,
    }
  end
}
