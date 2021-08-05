local M = {}

function M.config()
  vim.cmd [[packadd nvim-dap-python]]
  vim.cmd [[packadd nvim-dap-virtual-text]]

  vim.g.dap_virtual_text = true

  local dap = require "dap"

  -- C/C++/Rust
  local lldb_adapter = {
    type = "executable",
    attach = { pidProperty = "pid", pidSelect = "ask" },
    command = "lldb-vscode",
    env = { LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES" },
    name = "lldb",
  }
  dap.adapters.c = lldb_adapter
  dap.adapters.cpp = lldb_adapter
  dap.adapters.rust = lldb_adapter

  -- Python
  require("dap-python").setup "~/.local/share/virtualenvs/debugpy/bin/python"

  -- Key bindings
  local opts = { noremap = true, silent = true }
  vim.api.nvim_set_keymap("n", "<F5>", "<cmd>lua require'dap'.continue()<CR>", opts)
  vim.api.nvim_set_keymap("n", "<F10>", "<cmd>lua require'dap'.stop_over()<CR>", opts)
  vim.api.nvim_set_keymap("n", "<Space>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", opts)
  vim.api.nvim_set_keymap("n", "<Space>dr", "<cmd>lua require'dap'.repr.open()<CR>", opts)
  vim.api.nvim_set_keymap("n", "<Space>dn", "<cmd>lua require'dap-python'.test_method()<CR>", opts)
  vim.api.nvim_set_keymap("v", "<Space>ds", "<ESC>:lua require'dap-python'.debug_selection()<CR>", opts)
end

return M
