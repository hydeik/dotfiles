local LazyUtil = require "lazy.core.util"
local M = setmetatable({}, {
  __index = function(t, k)
    t[k] = require("rc.utils." .. k)
    return t[k]
  end,
})

-- delay notifications till vim.notify was replaced or after 500ms
M.lazy_notify = function()
  local notifs = {}
  local function temp(...)
    table.insert(notifs, vim.F.pack_len(...))
  end

  local orig = vim.notify
  vim.notify = temp

  local timer = vim.uv.new_timer()
  local check = assert(vim.uv.new_check())

  local replay = function()
    timer:stop()
    check:stop()
    if vim.notify == temp then
      vim.notify = orig -- put back the original notify if needed
    end
    vim.schedule(function()
      ---@diagnostic disable-next-line: no-unknown
      for _, notif in ipairs(notifs) do
        vim.notify(vim.F.unpack_len(notif))
      end
    end)
  end

  -- wait till vim.notify has been replaced
  check:start(function()
    if vim.notify ~= temp then
      replay()
    end
  end)
  -- or if it took more than 500ms, then something went wrong
  timer:start(500, 0, replay)
end

---@param msg string|string[]
---@param opts? LazyNotifyOpts
M.error = function(msg, opts)
  opts = opts or {}
  opts.level = vim.log.levels.ERROR
  LazyUtil.error(msg, opts)
end

---@param msg string|string[]
---@param opts? LazyNotifyOpts
M.info = function(msg, opts)
  opts = opts or {}
  opts.level = vim.log.levels.INFO
  LazyUtil.info(msg, opts)
end

---@param msg string|string[]
---@param opts? LazyNotifyOpts
M.warn = function(msg, opts)
  opts = opts or {}
  opts.level = vim.log.levels.WARN
  LazyUtil.warn(msg, opts)
end

--- Toggle Vim option
---@param silent boolean?
---@param values? {[1]:any, [2]:any}
function M.toggle(option, silent, values)
  if values then
    if vim.opt_local[option]:get() == values[1] then
      vim.opt_local[option] = values[2]
    else
      vim.opt_local[option] = values[1]
    end
    return M.info("Set " .. option .. " to " .. vim.opt_local[option]:get(), { title = "Option" })
  end
  vim.opt_local[option] = not vim.opt_local[option]:get()
  if not silent then
    if vim.opt_local[option]:get() then
      M.info("Enabled " .. option, { title = "Option" })
    else
      M.warn("Disabled " .. option, { title = "Option" })
    end
  end
end

--- Toggle diagnostics
local enabled = true
function M.toggle_diagnostics()
  enabled = not enabled
  if enabled then
    vim.diagnostic.enable()
    M.info("Enabled diagnostics", { title = "Diagnostics" })
  else
    vim.diagnostic.enable(false)
    M.warn("Disabled diagnostics", { title = "Diagnostics" })
  end
end

M.root_patterns = { ".git", "lua" }

---@param path string?
M.realpath = function(path)
  if path == "" or path == nil then
    return nil
  end
  path = vim.uv.fs_realpath(path) or path
  return vim.fs.normalize(path)
end

M.cwd = function()
  return M.realpath(vim.uv.cwd())
end

---@param buf? number
M.find_root_lsp = function(buf)
  buf = (buf == nil or buf == 0) and vim.api.nvim_get_current_buf() or buf --[=[@as number]=]
  local bufpath = M.realpath(vim.api.nvim_buf_get_name(buf))
  local roots = {} ---@type string[]
  if not bufpath then
    return {}
  end
  local clients = vim.lsp.get_clients { bufnr = buf }
  for _, client in pairs(clients) do
    local workspace = client.config.workspace_folders
    for _, ws in pairs(workspace or {}) do
      roots[#roots + 1] = vim.uri_to_fname(ws.uri)
    end
    if client.root_dir then
      roots[#roots + 1] = client.root_dir
    end
  end

  return vim.tbl_filter(function(path)
    path = vim.fs.normalize(path)
    return path and bufpath:find(path, 1, true) == 1
  end, roots)
end

---@param buf number
---@param patterns string|string[]
M.find_root_pattern = function(buf, patterns)
  patterns = type(patterns) == "string" and { patterns } or patterns
  local bufpath = M.realpath(vim.api.nvim_buf_get_name(buf)) or vim.uv.cwd()
  if not bufpath then
    return {}
  end
  local pattern = vim.fs.root(bufpath, patterns)
  return pattern and { pattern } or {}
end

-- returns the root directory based on:
-- * lsp workspace folders
-- * lsp root_dir
-- * root pattern of filename of the current buffer
-- * root pattern of cwd
---@param opts? { buf?: number, patterns?: string|string[] }
---@return string
M.find_root = function(opts)
  opts = opts or {}
  local buf = opts.buf or vim.api.nvim_get_current_buf()
  local patterns = opts.patterns and opts.patterns or M.root_patterns
  local roots = M.find_root_lsp(buf)
  table.sort(roots, function(a, b)
    return #a > #b
  end)
  local root = roots[1] --[=[@as string?]=]
  if not root then
    root = M.find_root_pattern(buf, patterns)[1]
    if not root then
      root = vim.uv.cwd()
    end
  end
  return root and root or ""
end

M.find_git_root = function()
  local root = M.find_root()
  local git_root = vim.fs.root(root, { ".git" })
  local ret = git_root and git_root or root
  return ret
end

---@generic T
---@param list T[]
---@return T[]
function M.list_unique(list)
  local ret = {}
  local seen = {}
  for _, v in ipairs(list) do
    if not seen[v] then
      table.insert(ret, v)
      seen[v] = true
    end
  end
  return ret
end

return M
