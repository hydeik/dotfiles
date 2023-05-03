local platform = require "rc.core.platform"
local home = os.getenv "HOME"

local M = {}

-- Path separator
M.seperator = package.config:sub(1, 1)

-- Join a list of paths together
---@param ... string list
---@return string
M.join = function(...)
  return table.concat({ ... }, M.seperator)
end

-- Define default values for important path locations
M.home = home
M.confighome = vim.fn.stdpath "config"
M.datahome = vim.fn.stdpath "data"
M.cachehome = vim.fn.stdpath "cache"
M.statehome = vim.fn.stdpath "state"

--- Returns if the path exists on disk
---@param filename string
---@return table|boolean
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
---@return string|nil
M.dirname = function(path)
  local strip_dir_pat = M.separator .. "([^" .. M.separator .. "]+)$"
  local strip_sep_pat = M.separator .. "$"
  if not path or #path == 0 then
    return
  end
  local result = path:gsub(strip_sep_pat, ""):gsub(strip_dir_pat, "")
  if #result == 0 then
    if platform.is_windows then
      return path:sub(1, 2):upper()
    else
      return "/"
    end
  end
  return result
end

return M
