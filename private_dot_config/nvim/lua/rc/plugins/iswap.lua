-- [iswap.nvim](https://github.com/mizlan/iswap.nvim)
--
-- Interactively select and swap function arguments, list elements, and more. Powered by tree-sitter.
--
return {
  "mizlan/iswap.nvim",
  after = "nvim-treesitter",
  config = function()
    vim.keymap.set("n", "<Leader>s", "<Cmd>ISwap<CR>", { silent = true })
    vim.keymap.set("n", "<Leader>S", "<Cmd>ISwapWith<CR>", { silent = true })
  end,
}
