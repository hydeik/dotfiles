-- [dial.nvim](https://github.com/monaqa/dial.nvim)
--
-- Enhanced increment/decrement plugin for Neovim.
--
return  {
    "monaqa/dial.nvim",
    keys = {
      { "n", "<Plug>(dial-" },
      { "v", "<Plug>(dial-" },
    },
    setup = function()
      vim.keymap.set({ "n", "v" }, "<C-a>", "<Plug>(dial-increment)")
      vim.keymap.set({ "n", "v" }, "<C-x>", "<Plug>(dial-decrement)")
      vim.keymap.set("v", "g<C-a>", "<Plug>(dial-increment-additional)")
      vim.keymap.set("v", "g<C-x>", "<Plug>(dial-decrement-additional)")
    end,
  }
