local ddc = {
  custom = setmetatable({}, {
    __index = function(_, key)
      return function(...)
        vim.call("ddc#custom#" .. key, ...)
      end
    end,
  }),
  map = setmetatable({}, {
    __index = function(_, key)
      return function(...)
        vim.call("ddc#map" .. key, ...)
      end
    end,
  }),
}

return setmetatable(ddc, {
  __index = function(_, key)
    return function(...)
      vim.call("ddc#" .. key, ...)
    end
  end,
})
