-- [bufferline.nvim](https://github.com/akinsho/bufferline.nvim)
--
-- A snazzy bufferline for Neovim
--
return {
  "akinsho/bufferline.nvim",
  requires = { "kyazdani42/nvim-web-devicons" },
  event = { "BufReadPre" },
  config = function()
    require("bufferline").setup {
      options = {
        always_show_bufferline = true,
      },
    }
  end,
}
