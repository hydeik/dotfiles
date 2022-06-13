-- [vim-eft](https://github.com/hrsh7th/vim-eft)
--
-- Enhanced f/t
--
return {
  "hrsh7th/vim-eft",
  keys = {
    { "n", "<Plug>(eft-" },
    { "o", "<Plug>(eft-" },
    { "x", "<Plug>(eft-" },
  },
  setup = function()
    vim.keymap.set({ "n", "x", "o" }, "f", "<Plug>(eft-f-repeatable)")
    vim.keymap.set({ "n", "x", "o" }, "F", "<Plug>(eft-F-repeatable)")
    vim.keymap.set({ "n", "x", "o" }, "t", "<Plug>(eft-t-repeatable)")
    vim.keymap.set({ "n", "x", "o" }, "T", "<Plug>(eft-T-repeatable)")
  end,
}
