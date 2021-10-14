local platform = require "rc.core.platform"
local home = os.getenv "HOME"

local M = {}

-- Path separator
M.sep = platform.is_windows and [[\]] or "/"

--- Join a list of paths together
---@params ... string
---@return string
function M.join(...)
  -- return table.concat(vim.tbl_flatten { ... }, M.sep):gsub(M.sep .. "+", M.sep)
  return table.concat(vim.tbl_flatten { ... }, M.sep)
end

-- Important paths
M.cache_home = M.join(home, ".cache", "nvim")
M.config_home = M.join(home, ".config", "nvim")
M.data_home = M.join(home, ".local", "share", "nvim")
M.pack_root = M.join(M.data_home, "site", "pack")
M.packer_compiled = M.join(M.config_home, "lua", "packer_compiled.lua")

--- Returns if the path exists on disk
---@param filename string
---@return boolean
function M.exists(filename)
  local stat = vim.loop.fs_stat(filename)
  return stat and stat.type or false
end

--- Returns if the path is a directory
---@param filename string
---@return boolean
function M.is_dir(filename)
  return M.exists(filename) == "directory"
end

--- Returns if the path is a file
---@param filename string
---@return boolean
function M.is_file(filename)
  return M.exists(filename) == "file"
end

--- Strip last component from file name
---@param path string
---@return string
local dirname
do
  local strip_dir_pat = M.sep .. "([^" .. M.sep .. "]+)$"
  local strip_sep_pat = M.sep .. "$"
  dirname = function(path)
    if not path then
      return
    end
    local result = path:gsub(strip_sep_pat, ""):gsub(strip_dir_pat, "")
    if #result == 0 then
      return "/"
    end
    return result
  end
end

M.dirname = dirname

return M
