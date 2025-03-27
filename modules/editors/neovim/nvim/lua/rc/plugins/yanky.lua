return {
  -- Improved Yank and Put functionalities for Neovim
  "gbprod/yanky.nvim",
  keys = {
    { "<Plug>(Yanky", mode = { "n", "x" } },
  },
  opts = {
    highlight = {
      timer = 150,
    },
    ring = {
      storage = jit.os:find "Windows" and "shada" or "sqlite",
    },
  },
  init = function()
    vim.keymap.set({ "n", "x" }, "y", "<Plug>(YankyYank)", { desc = "Yank Text" })
    vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)", { desc = "Put Text After Cursor" })
    vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyGPutBefore)", { desc = "Put Text Before Cursor" })
    vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyPutAfter)", { desc = "Put Text After Selection" })
    vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)", { desc = "Put Text After Selection" })
    vim.keymap.set("n", "<c-n>", "<Plug>(YankyCycleForward)", { desc = "Cycle Forward Through Yank History" })
    vim.keymap.set("n", "<c-p>", "<Plug>(YankyCycleBackward)", { desc = "Cycle Backward Through Yank History" })
    vim.keymap.set("n", "]p", "<Plug>(YankyPutIndentAfterLinewise)", { desc = "Put Indent After Cursor (Linewise)" })
    vim.keymap.set("n", "[p", "<Plug>(YankyPutIndentBeforeLinewise)", { desc = "Put Indent Before Cursor (Linewise)" })
    vim.keymap.set("n", "]P", "<Plug>(YankyPutIndentAfterLinewise)", { desc = "Put Indent After Cursor (Linewise)" })
    vim.keymap.set("n", "[P", "<Plug>(YankyPutIndentBeforeLinewise)", { desc = "Put Indent Before Cursor (Linewise)" })
    vim.keymap.set("n", ">p", "<Plug>(YankyPutIndentAfterShiftRight)", { desc = "Put and Indent Right" })
    vim.keymap.set("n", "<p", "<Plug>(YankyPutIndentAfterShiftLeft)", { desc = "Put and Indent Left" })
    vim.keymap.set("n", ">P", "<Plug>(YankyPutIndentBeforeShiftRight)", { desc = "Put Before and Indent Right" })
    vim.keymap.set("n", "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)", { desc = "Put Before and Indent Left" })
    vim.keymap.set("n", "=p", "<Plug>(YankyPutAfterFilter)", { desc = "Put After Applying a Filter" })
    vim.keymap.set("n", "=P", "<Plug>(YankyPutBeforeFilter)", { desc = "Put Before Applying a Filter" })
    vim.keymap.set("n", "<leader>p", function()
      vim.cmd [[YankyRingHistory]]
    end, { desc = "Open Yank History" })
  end,
}
