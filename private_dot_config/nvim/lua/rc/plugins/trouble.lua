-- A pretty diagnostics, references, telescope results, quickfix and location list
-- to help you solve all the trouble your code is causing.
local M = {
  "folke/trouble.nvim",
  cmd = { "TroubleToggle", "Trouble" },
}

M.config = function()
  require("trouble").setup {
    auto_open = false,
    use_diagnostic_signs = true,
  }
end

M.init = function()
  vim.keymap.set("n", "<Space>xx", "<cmd>TroubleToggle<CR>", { silent = true, desc = "Trouble" })
  vim.keymap.set(
    "n",
    "<Space>xw",
    "<cmd>TroubleToggle workspace_diagnostics<CR>",
    { silent = true, desc = "Trouble workspace diagnostics" }
  )
  vim.keymap.set(
    "n",
    "<Space>xd",
    "<cmd>TroubleToggle document_diagnostics<cr>",
    { silent = true, desc = "Trouble document diagnostics" }
  )
  vim.keymap.set("n", "<Space>xl", "<cmd>TroubleToggle loclist<CR>", { silent = true, desc = "Trouble location list" })
  vim.keymap.set("n", "<Space>xq", "<cmd>TroubleToggle quickfix<CR>", { silent = true, desc = "Trouble quickfix" })
end

return M
