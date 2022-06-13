-- [vim-niceblock](https://github.com/kana/vim-niceblock)
--
-- Make blockwise visual mode more useful
--
return {
    "kana/vim-niceblock",
    keys = { { "v", "<Plug>(niceblock-" } },
    setup = function()
      vim.g.niceblock_no_default_key_mappings = 1
      vim.keymap.set("v", "I", "<Plug>(niceblock-I)")
      vim.keymap.set("v", "gI", "<Plug>(niceblock-gI)")
      vim.keymap.set("v", "A", "<Plug>(niceblock-A)")
    end,
  }
