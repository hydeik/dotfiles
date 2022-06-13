-- [satellite.nvim](https://github.com/lewis6991/satellite.nvim)
--
-- Decorate scrollbar for Neovim
--
return {
  "lewis6991/satellite.nvim",
  event = { "VimEnter" },
  config = function()
    require("satellite").setup()
  end
}
