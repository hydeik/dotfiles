-- [nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag)
--
-- A super powerful autopair plugin for Neovim that supports multiple characters.
--
return {
  "windwp/nvim-ts-autotag",
  after = { "nvim-treesitter" },
  event = { "InsertEnter" },
  config = function()
    require("nvim-ts-autotag").setup()
  end,
}
