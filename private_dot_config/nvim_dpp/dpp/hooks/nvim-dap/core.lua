--- [nvim-dap](https://github.com/mfussenegger/nvim-dap)
--- Debug Adapter Protocol client implementation for Neovim

-- lua_add {{{

if not vim.tbl_isempty(require("dpp").get "which-key.nvim") then
  require("which-key").add {
    { "<Space>d", group = "+debug", mode = { "n", "v" } },
  }
end

local get_args = function(config)
  local args = type(config.args) == "function" and (config.args() or {}) or config.args or {} --[[@as string[] | string ]]
  local args_str = type(args) == "table" and table.concat(args, " ") or args --[[@as string]]

  config = vim.deepcopy(config)
  ---@cast args string[]
  config.args = function()
    local new_args = vim.fn.expand(vim.fn.input("Run with args: ", args_str)) --[[@as string]]
    if config.type and config.type == "java" then
      ---@diagnostic disable-next-line: return-type-mismatch
      return new_args
    end
    return require("dap.utils").splitstr(new_args)
  end
  return config
end

vim.keymap.set("n", "<Space>dB", function()
  require("dap").set_breakpoint(vim.fn.input "Breakpoint condition: ")
end, { desc = "Breakpoint Condition" })

vim.keymap.set("n", "<Space>da", function()
  require("dap").continue { before = get_args }
end, { desc = "Run with Args" })

vim.keymap.set("n", "<Space>db", function()
  require("dap").toggle_breakpoint()
end, { desc = "Toggle Breakpoint" })

vim.keymap.set("n", "<Space>dC", function()
  require("dap").run_to_cursor()
end, { desc = "Run to Cursor" })

vim.keymap.set("n", "<Space>dc", function()
  require("dap").continue()
end, { desc = "Run/Continue" })

vim.keymap.set("n", "<Space>dg", function()
  require("dap").goto_()
end, { desc = "Go to Line (No Execute)" })

vim.keymap.set("n", "<Space>di", function()
  require("dap").step_info()
end, { desc = "Step Info" })

vim.keymap.set("n", "<Space>dj", function()
  require("dap").down()
end, { desc = "Down" })

vim.keymap.set("n", "<Space>dk", function()
  require("dap").up()
end, { desc = "Up" })

vim.keymap.set("n", "<Space>dl", function()
  require("dap").run_last()
end, { desc = "Run Last" })

vim.keymap.set("n", "<Space>dO", function()
  require("dap").step_over()
end, { desc = "Step Over" })

vim.keymap.set("n", "<Space>do", function()
  require("dap").step_out()
end, { desc = "Step Out" })

vim.keymap.set("n", "<Space>dr", function()
  require("dap").repl.toggle()
end, { desc = "Toggle REPL" })

vim.keymap.set("n", "<Space>ds", function()
  require("dap").session()
end, { desc = "Session" })

vim.keymap.set("n", "<Space>dt", function()
  require("dap").terminate()
end, { desc = "Terminate" })

vim.keymap.set("n", "<Space>dw", function()
  require("dap.ui.widgets").hover()
end, { desc = "Widgets" })
-- }}}

-- lua_source {{{
local dap_clients = {
  "codelldb",
}

require("rc.plugins.mason").ensure_installed(dap_clients)

-- Custom highlights
vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

for name, sign in pairs(require("rc.core.custom_icons").dap) do
  sign = type(sign) == "table" and sign or { sign }
  vim.fn.sign_define(
    "Dap" .. name,
    { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
  )
end
-- }}}
