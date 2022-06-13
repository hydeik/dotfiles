-- [nvim-hlslens](https://github.com/kevinhwang91/nvim-hlslens)
--
-- Better glance searched information
--
return {
  "kevinhwang91/nvim-hlslens",
  module = { "hlslens" },
  setup = function()
    vim.keymap.set(
      "n",
      "n",
      "<cmd>execute('normal! ' . v:count1 . 'n')<CR><cmd>lua require'hlslens'.start()<CR>",
      { silent = true }
    )
    vim.keymap.set(
      "n",
      "N",
      "<cmd>execute('normal! ' . v:count1 . 'N')<CR><cmd>lua require'hlslens'.start()<CR>",
      { silent = true }
    )
    vim.keymap.set("n", "*", "*<cmd>lua require'hlslens'.start()<CR>", { silent = true })
    vim.keymap.set("n", "#", "#<cmd>lua require'hlslens'.start()<CR>", { silent = true })
    vim.keymap.set("n", "g*", "g*<cmd>lua require'hlslens'.start()<CR>", { silent = true })
    vim.keymap.set("n", "g#", "g#<cmd>lua require'hlslens'.start()<CR>", { silent = true })
  end,
  config = function()
    require("hlslens").setup {
      auto_enable = true,
      calm_down = true,
    }
  end,
}
