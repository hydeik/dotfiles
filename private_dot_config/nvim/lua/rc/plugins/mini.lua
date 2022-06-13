-- [mini.nvim](https://github.com/echasnovski/mini.nvim)
--
-- Collection of minimal, independent, and fast Lua modules dedicated to improve Neovim experience.
-- Currently, only the mini.tailspace module is used.
--
return {
  "echasnovski/mini.nvim",
  event = { "BufReadPost" },
  config = function()
    require("mini.trailspace").setup {}
    vim.keymap.set("n", "<Leader>x", "<Cmd>lua MiniTrailspace.trim()<CR>", { silent = true })
  end,
}
