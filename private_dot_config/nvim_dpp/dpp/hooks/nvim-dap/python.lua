--- [nvim-dap-python](https://github.com/mfussenegger/nvim-dap-python)
--- An extension for nvim-dap, providing default configurations for python and
--- methods to debug individual test methods or classes.

-- lua_source {{{
-- TODO: Add config for Windows
local venv = os.getenv "VIRTUAL_ENV"
if not venv then
  venv = "/usr"
end
local cmd = string.format("%s/bin/python", vim.fn.expand(venv))

require("dap-python").setup(cmd)
-- }}}

-- lua_python {{{
vim.keymap.set("n", "<Space>dPt", function()
  require("dap-python").test_method()
end, { desc = "Debug Method" })

vim.keymap.set("n", "<Space>dPc", function()
  require("dap-python").test_class()
end, { desc = "Debug Class" })
-- }}}
