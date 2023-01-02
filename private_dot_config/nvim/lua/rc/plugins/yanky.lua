-- Improved Yank and Put functionalities for Neovim
local M = {
  "gbprod/yanky.nvim",
  dependencies = {
    "kkharji/sqlite.lua",
  },
  keys = {
    { "<Plug>(Yanky", mode = { "n", "x" } },
  },
}

M.init = function()
  vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
  vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
  vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
  vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")
  vim.keymap.set("n", "<c-n>", "<Plug>(YankyCycleForward)")
  vim.keymap.set("n", "<c-p>", "<Plug>(YankyCycleBackward)")
  vim.keymap.set({ "n", "x" }, "y", "<Plug>(YankyYank)")
  vim.keymap.set("n", "=p", "<Plug>(YankyPutAfterFilter)")
  vim.keymap.set("n", "=p", "<Plug>(YankyPutBeforeFilter)")
  vim.keymap.set("n", "<leader>P", function()
    require("telescope").extensions.yank_history.yank_history {}
  end, { desc = "Paste from Yanky" })
end

M.config = function()
  require("yanky").setup {
    highlight = {
      timer = 150,
    },
    ring = {
      storage = jit.os:find "Windows" and "shada" or "sqlite",
    },
  }
  -- Telescope picker
  require("telescope").load_extension "yank_history"
end

return M
