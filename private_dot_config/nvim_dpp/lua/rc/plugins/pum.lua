local pum = {
  map = setmetatable({}, {
    __index = function(_, map_key)
      return function(...)
        return vim.call("pum#map#" .. map_key, ...)
      end
    end,
  }),
}

return setmetatable(pum, {
  __index = function(_, key)
    return function(...)
      return vim.call("pum#" .. key, ...)
    end
  end,
})
