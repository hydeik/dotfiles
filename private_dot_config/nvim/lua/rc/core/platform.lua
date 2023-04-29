local M = {}

local uname = vim.loop.os_uname()

local arch_aliases = {
  ["x86_64"] = "x64",
  ["i386"] = "x86",
  ["i686"] = "x86", -- x86 compat
  ["aarch64"] = "arm64",
  ["aarch64_be"] = "arm64",
  ["armv8b"] = "arm64", -- arm64 compat
  ["armv8l"] = "arm64", -- arm64 compat
}

M.arch = arch_aliases[uname.machine] or uname.machine
M.sysname = uname.sysname

M.is_mac = M.sysname == "Darwin"
M.is_linux = M.sysname == "Linux"
M.is_windows = M.sysname == "Windows_NT"
M.is_wsl = not (string.find(uname.release, "microsoft") == nil)

return M
