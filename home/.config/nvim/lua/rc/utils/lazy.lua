local LazyUtil = require "lazy.core.util"
local M = setmetatable({}, {
  __index = function(t, k)
    if LazyUtil[k] then
      return LazyUtil[k]
    end
  end,
})

---@param name string
M.get_plugin = function(name)
  return require("lazy.core.config").spec.plugins[name]
end

---@param name string
M.has_plugin = function(name)
  return M.get_plugin(name) ~= nil
end

---@param name string
---@param path string?
M.get_plugin_path = function(name, path)
  local plugin = M.get_plugin(name)
  path = path and "/" .. path or ""
  return plugin and (plugin.dir .. path)
end

---@param name string
M.get_plugin_opts = function(name)
  local plugin = M.get_plugin(name)
  if not plugin then
    return {}
  end
  local Plugin = require "lazy.core.plugin"
  return Plugin.values(plugin, "opts", false)
end

---@param name string
M.is_loaded = function(name)
  local Config = require "lazy.core.config"
  return Config.plugins[name] and Config.plugins[name]._.loaded
end

---@param name string
---@param fn fun(name:string)
M.on_load = function(name, fn)
  if M.is_loaded(name) then
    fn(name)
  else
    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyLoad",
      callback = function(event)
        if event.data == name then
          fn(name)
          return true
        end
      end,
    })
  end
end

return M
