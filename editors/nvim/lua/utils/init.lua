local M = {}

--- OS specific settings
M.os = (function()
  local is_windows = vim.loop.os_uname().version:match "Windows"
  local is_mac = vim.loop.os_uname().version:match "Darwin"

  -- Get back the output of an external command
  local function capture(cmd, raw)
    local f = assert(io.popen(cmd, "r"))
    local s = assert(f:read "*a")
    f:close()
    if raw then
      return s
    end
    s = string.gsub(s, "^%s+", "")
    s = string.gsub(s, "%s+$", "")
    s = string.gsub(s, "[\n\r]+", " ")
    return s
  end

  return {
    is_windows = is_windows,
    is_mac = is_mac,
    capture = capture,
  }
end)()

-- Path utilities (picked from nvim_lsp/utils.lua)
M.path = (function()
  local function exists(filename)
    local stat = vim.loop.fs_stat(filename)
    return stat and stat.type or false
  end

  local function is_dir(filename)
    return exists(filename) == "directory"
  end

  local function is_file(filename)
    return exists(filename) == "file"
  end

  local path_sep = M.os.is_windows and "\\" or "/"

  local dirname
  do
    local strip_dir_pat = path_sep .. "([^" .. path_sep .. "]+)$"
    local strip_sep_pat = path_sep .. "$"
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

  local function path_join(...)
    local result = table.concat(vim.tbl_flatten { ... }, path_sep):gsub(path_sep .. "+", path_sep)
    return result
  end

  return {
    dirname = dirname,
    exists = exists,
    is_dir = is_dir,
    is_file = is_file,
    join = path_join,
    sep = path_sep,
  }
end)()

---Get a variable with defaults
function M.get_var(name, default_value)
  local ok, data = pcall(vim.api.nvim_get_var, name)
  return ok and data or default_value
end

---Get a buffer local variable with defaults
function M.buf_get_var(bufnr, name, default_value)
  local ok, data = pcall(vim.api.nvim_buf_get_var, bufnr, name)
  return ok and data or default_value
end

---Echo a log message.
---@param msg string  The body of the log message
---@param hl string (optional) The highlight group for the log message [Default: "Todo"]
---@param name string (optional) The name to distinguish log message [default: "Neovim"]
function M.log(msg, hl, name)
  name = name or "Neovim"
  hl = hl or "Todo"
  vim.api.nvim_echo({ { name .. ": ", hl }, { msg } }, true, {})
end

---Echo a warning message.
---@param msg string  The body of the log message
---@param name string (optional) The name to distinguish log message [default: "Neovim"]
function M.warn(msg, name)
  M.log(msg, "LspDiagnosticsDefaultWarning", name)
end

---Echo an error message.
---@param msg string  The body of the log message
---@param name string (optional) The name to distinguish log message [default: "Neovim"]
function M.error(msg, name)
  M.log(msg, "LspDiagnosticsDefaultError", name)
end

---Echo an info message.
---@param msg string  The body of the log message
---@param name string (optional) The name to distinguish log message [default: "Neovim"]
function M.info(msg, name)
  M.log(msg, "LspDiagnosticsDefaultInformation", name)
end

---Toggle Vim options
---@param option string  Vim option to toggle
---@param silent boolean If true, suppress the message
function M.toggle_option(option, silent)
  local info = vim.api.nvim_get_option_info(option)
  local scopes = { buf = "bo", win = "wo", global = "o" }
  local scope = scopes[info.scope]
  local options = vim[scope]
  options[option] = not options[option]
  if silent ~= true then
    if options[option] then
      M.info("enabled vim." .. scope .. "." .. option, "Toggle")
    else
      M.warn("disabled vim." .. scope .. "." .. option, "Toggle")
    end
  end
end

return M
