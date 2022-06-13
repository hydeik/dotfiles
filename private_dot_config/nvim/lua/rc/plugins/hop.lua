-- [hop.nvim](https://github.com/phaazon/hop.nvim)
--
-- Neovim motions on speed!
--
return {
  "phaazon/hop.nvim",
  module = { "hop" },
  setup = function()
    vim.keymap.set({ "n", "x", "o" }, "ss", "<Cmd>lua require'hop'.hint_char2()<CR>")
    vim.keymap.set({ "n", "x", "o" }, "sl", "<Cmd>lua require'hop'.hint_lines()<CR>")
    vim.keymap.set({ "n", "x", "o" }, "s/", "<Cmd>lua require'hop'.hint_patterns()<CR>")
  end,
  config = function()
    require("hop").setup()
  end,
}
