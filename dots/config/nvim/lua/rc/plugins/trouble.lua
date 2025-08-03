return {
  -- A pretty diagnostics, references, telescope results, quickfix and location list
  -- to help you solve all the trouble your code is causing.
  "folke/trouble.nvim",
  lazy = true,
  cmd = { "TroubleToggle", "Trouble" },
  opts = {
    auto_open = false,
    use_diagnostic_signs = true,
  },
  keys = {
    { "<Space>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
    { "<Space>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
    { "<Space>cs", "<cmd>Trouble symbols toggle<cr>", desc = "Symbols (Trouble)" },
    { "<Space>cS", "<cmd>Trouble lsp toggle<cr>", desc = "LSP references/definitions/... (Trouble)" },
    { "<Space>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
    { "<Space>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
    {
      "[q",
      function()
        if require("trouble").is_open() then
          require("trouble").prev { skip_groups = true, jump = true }
        else
          local ok, err = pcall(vim.cmd.cprev)
          if not ok then
            vim.notify(err, vim.log.levels.ERROR)
          end
        end
      end,
      desc = "Previous Trouble/Quickfix Item",
    },
    {
      "]q",
      function()
        if require("trouble").is_open() then
          require("trouble").next { skip_groups = true, jump = true }
        else
          local ok, err = pcall(vim.cmd.cnext)
          if not ok then
            vim.notify(err, vim.log.levels.ERROR)
          end
        end
      end,
      desc = "Next Trouble/Quickfix Item",
    },
  },
}
