--
-- Utility functions for handling file system
--
local M = {}

--- The directory separator string
M.sep = package.config:sub(1, 1)

--- Join a list of strings into a path string
--- @params ... string(s) to be concatenated
--- @return string
M.join = function(...)
  return table.concat(vim.tbl_flatten { ... }, M.sep):gsub(M.sep .. "+", M.sep)
end

--- Returns if the path exists on disk
--- @param path string
--- @return boolean
M.exists = function(path)
  local stat = vim.loop.fs_stat(path)
  return stat and stat.type or false
end

--- Returns if the path is a directory
--- @param path string
--- @return boolean
M.is_dir = function(path)
  return M.exists(path) == "directory"
end

--- Returns if the path is a file
--- @param path string  The path of the file
--- @return boolean
M.is_file = function(path)
  return M.exists(path) == "file"
end

--- Strip last component from file name
--- @param path string
--- @return string
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

--- Returns the content of the given file
--- @param path string The path of the file
--- @return string
M.read_file = function(path)
  local fd = vim.loop.fs_open(path, "r", 438)
  local stat = vim.loop.fs_fstat(fd)
  local data = vim.loop.fs_read(fd, stat.size, 0)
  vim.loop.fs_close(fd)

  return data
end

--- Writes the given string into given file
--- @param path string The path of the file
--- @param content string The content to be written in the file
--- @param mode string The mode for opening the file, e.g. 'w+'
M.write_file = function(path, content, mode)
  -- 644 sets read and write permissions for the owner, and it sets read-only
  -- mode for the group and others.
  vim.loop.fs_open(path, mode, tonumber("644", 8), function(err, fd)
    if not err then
      local fpipe = vim.loop.new_pipe(false)
      vim.loop.pipe_open(fpipe, fd)
      vim.loop.write(fpipe, content)
    end
  end)
end

return M
