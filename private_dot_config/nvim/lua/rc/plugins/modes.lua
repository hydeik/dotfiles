-- [modes.nvim](https://github.com/mvllow/modes.nvim)
--
-- Prismatic line decorations for the adventurous vim user
--
return {
  "mvllow/modes.nvim",
  event = { "BufReadPost" },
  config = function()
    require("modes").setup()
  end,
}
