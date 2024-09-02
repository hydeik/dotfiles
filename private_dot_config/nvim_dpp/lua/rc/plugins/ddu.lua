local ddu = {
  custom = setmetatable({}, {
    __index = function(_, key)
      return function(...)
        vim.call("ddu#custom#" .. key, ...)
      end
    end,
  }),
  ui = setmetatable({}, {
    __index = function(_, key)
      return function(...)
        vim.call("ddu#ui#" .. key, ...)
      end
    end,
  }),
}

return setmetatable(ddu, {
  __index = function(_, key)
    return function(...)
      vim.call("ddu#" .. key, ...)
    end
  end,
})
