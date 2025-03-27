local M = {}

---@param buf? number
function M.info(buf)
  buf = buf or vim.api.nvim_get_current_buf()
  local gaf = vim.g.autoformat == nil or vim.g.autoformat
  local baf = vim.b[buf].autoformat
  local enabled = M.enabled(buf)
  local lines = {
    "# Status",
    ("- [%s] global **%s**"):format(gaf and "x" or " ", gaf and "enabled" or "disabled"),
    ("- [%s] buffer **%s**"):format(
      enabled and "x" or " ",
      baf == nil and "inherit" or baf and "enabled" or "disabled"
    ),
  }

  local formatters, use_lsp = require("conform").list_formatters_to_run(buf)
  local have = false
  if #formatters > 0 or use_lsp then
    have = true
    lines[#lines + 1] = "\n# Formatters available:" or ""
    for _, formatter in ipairs(formatters) do
      lines[#lines + 1] = ("- [%s] **%s**"):format(formatter.available and "x" or " ", formatter.name)
    end
    if use_lsp then
      lines[#lines + 1] = "- [x] LSP format"
    end
  end
  if not have then
    lines[#lines + 1] = "\n***No formatters available for this buffer.***"
  end

  require("rc.utils.lazy")[enabled and "info" or "warn"](
    table.concat(lines, "\n"),
    { title = "Format (" .. (enabled and "enabled" or "disabled") .. ")" }
  )
end

---@param buf? number
function M.enabled(buf)
  buf = (buf == nil or buf == 0) and vim.api.nvim_get_current_buf() or buf
  local gaf = vim.g.autoformat
  local baf = vim.b[buf].autoformat

  -- If the buffer has a local value, use that
  if baf ~= nil then
    return baf
  end

  -- Otherwise use the global value if set, or true by default
  return gaf == nil or gaf
end

---@param buf? boolean
function M.toggle(buf)
  M.enable(not M.enabled(), buf)
end

---@param enable? boolean
---@param buf? boolean
function M.enable(enable, buf)
  if enable == nil then
    enable = true
  end
  if buf then
    vim.b.autoformat = enable
  else
    vim.g.autoformat = enable
    vim.b.autoformat = nil
  end
  M.info()
end

---@param buf? boolean
M.snacks_toggle = function(buf)
  return Snacks.toggle {
    name = "Auto Format (" .. (buf and "Buffer" or "Global") .. ")",
    get = function()
      if not buf then
        return vim.g.autoformat == nil or vim.g.autoformat
      end
      return M.enabled()
    end,
    set = function(state)
      M.enable(state, buf)
    end,
  }
end

return M
