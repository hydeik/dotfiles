local M = {}

-- Ensure the provided tools are installed via Mason
---@param tools string[]
M.ensure_installed = function(tools)
  -- Auto install tools
  local mr = require "mason-registry"

  local callback = function()
    vim.iter(tools):each(function(arg)
      local pkg = mr.get_package(arg)
      if not pkg:is_installed() then
        pkg:install()
      end
    end)
  end

  if mr.refresh then
    mr.refresh(callback)
  else
    callback()
  end
end

return M
