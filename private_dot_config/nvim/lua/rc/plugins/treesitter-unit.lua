-- [treesitter-unit](https://github.com/David-Kunz/treesitter-unit)
--
-- A Neovim plugin to deal with treesitter units
--
return {
  "David-Kunz/treesitter-unit",
  after = "nvim-treesitter",
  config = function()
    vim.keymap.set("x", "iu", ":lua require('treesitter-unit').select()<CR>", { silent = true })
    vim.keymap.set("x", "au", ":lua require('treesitter-unit').select(true)<CR>", { silent = true })
    vim.keymap.set("o", "iu", ":<C-u>lua require('treesitter-unit').select()<CR>", { silent = true })
    vim.keymap.set("o", "au", ":<C-u>lua require('treesitter-unit').select(true)<CR>", { silent = true })
  end,
}
