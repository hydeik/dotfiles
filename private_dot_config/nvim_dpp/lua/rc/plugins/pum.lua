local M = setmetatable({}, {
  __index = function(_, key)
    return function(...)
      if key == "map" then
        return setmetatable({}, {
          __index = function(_, map_key)
            return function(...)
              return vim.call("pum#map#" .. map_key, ...)
            end
          end,
        })
      end
      return vim.call("pum#" .. key, ...)
    end
  end,
})

return M
