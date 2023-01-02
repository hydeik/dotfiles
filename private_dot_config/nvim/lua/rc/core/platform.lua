local M = {}

-- OS type
local uname = vim.loop.os_uname()
M.is_mac = uname.sysname == "Darwin"
M.is_linux = uname.sysname == "Linux"
M.is_windows = uname.sysname == "Windows_NT"
M.is_wsl = not (string.find(uname.release, "microsoft") == nil)

-- Path separator
M.sep = M.is_windows and [[\]] or "/"

-- Important path locations
M.cache_dir = vim.fn.stdpath("cache")
M.config_dir = vim.fn.stdpath("config")
M.data_dir = vim.fn.stdpath("data")
M.state_dir = vim.fn.stdpath("state")

return M
