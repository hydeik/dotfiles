local M = {}

--- Echo a log message.
--- @param msg string  The body of the log message
--- @param hl string (optional) The highlight group for the log message [Default: "Todo"]
--- @param name string (optional) The name to distinguish log message [default: "Neovim"]
M.log = function(msg, hl, name)
  name = name or "Neovim"
  hl = hl or "Todo"
  vim.api.nvim_echo({ { name .. ": ", hl }, { msg } }, true, {})
end

--- Echo a warning message.
--- @param msg string  The body of the log message
--- @param name string (optional) The name to distinguish log message [default: "Neovim"]
M.warn = function(msg, name)
  M.log(msg, "LspDiagnosticsDefaultWarning", name)
end

--- Echo an error message.
--- @param msg string  The body of the log message
--- @param name string (optional) The name to distinguish log message [default: "Neovim"]
M.error = function(msg, name)
  M.log(msg, "LspDiagnosticsDefaultError", name)
end

--- Echo an info message.
--- @param msg string  The body of the log message
--- @param name string (optional) The name to distinguish log message [default: "Neovim"]
M.info = function(msg, name)
  M.log(msg, "LspDiagnosticsDefaultInformation", name)
end

--- Toggle Vim options
--- @param option string  Vim option to toggle
--- @param silent boolean If true, suppress the message
M.toggle_option = function (option, silent)
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
