return {
  -- Improved Yank and Put functionalities for Neovim
  "gbprod/yanky.nvim",
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  opts = {
    highlight = {
      timer = 150,
    },
    ring = {
      storage = jit.os:find "Windows" and "shada" or "sqlite",
    },
  },
  keys = {
    { "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank Text" },
    { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put Text After Cursor" },
    { "P", "<Plug>(YankyGPutBefore)", mode = { "n", "x" }, desc = "Put Text Before Cursor" },
    { "gp", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put Text After Selection" },
    { "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" }, desc = "Put Text After Selection" },
    { "<c-n>", "<Plug>(YankyCycleForward)", desc = "Cycle Forward Through Yank History" },
    { "<c-p>", "<Plug>(YankyCycleBackward)", desc = "Cycle Backward Through Yank History" },
    { "]p", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put Indent After Cursor (Linewise)" },
    { "[p", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put Indent Before Cursor (Linewise)" },
    { "]P", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put Indent After Cursor (Linewise)" },
    { "[P", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put Indent Before Cursor (Linewise)" },
    { ">p", "<Plug>(YankyPutIndentAfterShiftRight)", desc = "Put and Indent Right" },
    { "<p", "<Plug>(YankyPutIndentAfterShiftLeft)", desc = "Put and Indent Left" },
    { ">P", "<Plug>(YankyPutIndentBeforeShiftRight)", desc = "Put Before and Indent Right" },
    { "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)", desc = "Put Before and Indent Left" },
    { "=p", "<Plug>(YankyPutAfterFilter)", desc = "Put After Applying a Filter" },
    { "=P", "<Plug>(YankyPutBeforeFilter)", desc = "Put Before Applying a Filter" },
    {
      "<leader>p",
      function()
        vim.cmd [[YankyRingHistory]]
      end,
      mode = { "n", "x" },
      desc = "Open Yank History",
    },
  },
}
