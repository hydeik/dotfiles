-- A pretty diagnostics, references, telescope results, quickfix and location list
-- to help you solve all the trouble your code is causing.
return {
  "folke/trouble.nvim",
  cmd = { "TroubleToggle", "Trouble" },
  opts = {
    auto_open = false,
    use_diagnostic_signs = true,
  },
  keys = {
    { "<Space>xx", "<cmd>TroubleToggle document_diagnostics<CR>", desc = "Document Diagnostics (Trouble)" },
    { "<Space>xX", "<cmd>TroubleToggle workspace_diagnostics<CR>", desc = "Workspace Diagnostics (Trouble)" },
    { "<Space>xL", "<cmd>TroubleToggle loclist<CR>", desc = "Location List (Trouble)" },
    { "<Space>xQ", "<cmd>TroubleToggle quickfix<CR>", desc = "Quickfix List (Trouble)" },
    {
      "[q",
      function()
        if require("trouble").is_open() then
          require("trouble").previous { skip_groups = true, jump = true }
        else
          vim.cmd.cprev()
        end
      end,
      desc = "Previous trouble/quickfix item",
    },
    {
      "]q",
      function()
        if require("trouble").is_open() then
          require("trouble").next { skip_groups = true, jump = true }
        else
          vim.cmd.cnext()
        end
      end,
      desc = "Next trouble/quickfix item",
    },
  },
}
