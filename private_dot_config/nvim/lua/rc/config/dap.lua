local M = {}

function M.setup()
  vim.keymap.set("n", "<F1>", "<Cmd>lua require'dap'.step_back()<CR>", { silent = true })
  vim.keymap.set("n", "<F2>", "<Cmd>lua require'dap'.step_into()<CR>", { silent = true })
  vim.keymap.set("n", "<F3>", "<Cmd>lua require'dap'.step_over()<CR>", { silent = true })
  vim.keymap.set("n", "<F4>", "<Cmd>lua require'dap'.step_out()<CR>", { silent = true })
  vim.keymap.set("n", "<F5>", "<Cmd>lua require'dap'.continue()<CR>", { silent = true })
  vim.keymap.set("n", "<Space>db", "<Cmd>lua require'dap'.toggle_breakpoint()<CR>", { silent = true })
  vim.keymap.set("n", "<Space>dr", "<Cmd>lua require'dap'.repr.open()<CR>", { silent = true })
  vim.keymap.set("n", "<Space>dn", "<Cmd>lua require'dap-python'.test_method()<CR>", { silent = true })
  vim.keymap.set("n", "<Space>ds", "<ESC>:lua require'dap-python'.debug_selection()<CR>", { silent = true })
  vim.keymap.set("n", "<Space>de", "<Cmd>lua require'dapui'.eval()<CR>", { silent = true })
  vim.keymap.set("n", "<Space>dE", function()
    require'dapui'.eval(vim.fn.input("[DAP] Condition > "))
  end, { silent = true })
end

function M.config()
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
end

return M
