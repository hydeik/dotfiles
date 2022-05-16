local M = {}

-- [[ Wrapper around common buffer/window operations ]]
-- (I reffer https://github.com/tjdevries/express_line.nvim/blob/master/lua/el/meta.lua)
local buf_lookup = {
  -- File type
  filetype = function(buffer)
    return vim.api.nvim_buf_get_option(buffer.bufnr, "filetype")
  end,
  -- Full file name
  name = function(buffer)
    return vim.api.nvim_buf_get_name(buffer.bufnr)
  end,
  -- Tail of the file name
  tail = function(buffer)
    return vim.fn.fnamemodify(buffer.name, ":t")
  end,
  -- Extension of the file name
  extension = function(buffer)
    return vim.fn.fnamemodify(buffer.name, ":e")
  end,
  -- Check whether the buffer is active.
  is_active = function(buffer)
    return buffer.bufnr == vim.api.nvim_get_current_buf()
  end,
}

local Buffer = {}
local buf_mt = {
  __index = function(t, k)
    local result = nil
    if Buffer[k] ~= nil then
      result = Buffer[k]
    elseif buf_lookup[k] ~= nil then
      result = buf_lookup[k](t)
    end
    t[k] = result
    return t[k]
  end
}

function Buffer:new(bufnr)
  if bufnr == 0 then
    bufnr = vim.api.nvim_buf_get_number(0)
  end
  return setmetatable({ bufnr = bufnr }, buf_mt)
end

-- [[ Components ]]

-- [ File info ]
local function file_readonly(buffer)
  return vim.api.nvim_buf_get_option(buffer.bufnr, "readonly") and " " or ""
end

local function file_modified(buffer)
  if vim.tbl_contains({ "help", "denite", "fzf", "tagbar" }, buffer.filetype) then
    return ""
  end
  if vim.api.nvim_buf_get_option(buffer.bufnr, "modifiable") then
    if vim.api.nvim_buf_get_option(buffer.bufnr, "modified") then
      return " "
    end
  end
  return ""
end

local function file_icon(buffer)
  local ft = buffer.filetype
  if #ft > 0 then
    local ok, devicons = pcall(require, "nvim-web-devicons")
    if ok then
      local icon = devicons.get_icon(buffer.tail, buffer.extension)
      if icon ~= nil then
        return icon
      elseif ft == "help" then
        return ""
      end
    end
  end
  return ""
end

local function file_size(buffer)
  local file = buffer.name
  if string.len(file) == 0 then
    return ""
  end
  -- Format file size
  local size = vim.fn.getfsize(file)
  if size == 0 or size == -1 or size == -2 then
    return ""
  end
  local kb = 1024
  local mb = kb * 1024
  local gb = mb * 1024
  local tb = gb * 1024
  if size < kb then
    size = size .. "B "
  elseif size < mb then
    size = string.format("%.1f%s", size / kb, "KiB")
  elseif size < gb then
    size = string.format("%.1f%s", size / mb, "MiB")
  elseif size < tb then
    size = string.format("%.1f%s", size / gb, "GiB")
  else
    size = string.format("%.1f%s", size / tb, "TiB")
  end
  return size
end

local function file_name(buffer)
  local ft_lean = { "tagbar", "vista", "defx", "coc-explorer", "magit" }
  local ft = buffer.filetype
  if vim.tbl_contains(ft_lean, ft) then
    return " "
  end

  local name = buffer.name -- full path
  if name == "" then
    name = "[No Name]"
  else
    name = vim.fn.fnamemodify(name, ":.") -- path relative to current directory
    if #name > 24 then
      name = vim.fn.pathshorten(name)
    end
  end
  return name
end

-- file encoding & format
local function file_encoding(buffer)
  local fenc = vim.api.nvim_buf_get_option(buffer.bufnr, "fileencoding")
  if fenc == "" then
    fenc = vim.o.encoding
  end
  return fenc
end

local function file_format(buffer)
  local ff = vim.api.nvim_buf_get_option(buffer.bufnr, "fileformat")
  local icon
  if ff == "mac" then
    icon = " "
  elseif ff == "unix" then
    icon = " "
  elseif ff == "dos" then
    icon = " "
  end
  return icon
end

-- localtion (line number and column number)
local function location()
  return [[ %l/%L  %-2v]]
end

local function progress()
  return [[%3P]]
end

-- [ Git info (using gitsigns.nvim) ]
local function git_branch()
  local branch = vim.b.gitsigns_head or vim.g.gitsigns_head or ""
  if #branch > 0 then
    return string.format(" %s", branch)
  end
  return ""
end

local function git_diff(type, icon)
  local d = vim.b.gitsigns_status_dict
  if d and d[type] and d[type] > 0 then
    return string.format("%s%d", icon, d[type])
  end
  return ""
end

local function git_diff_added()
  return git_diff("added", " ")
end

local function git_diff_removed()
  return git_diff("removed", " ")
end

local function git_diff_changed()
  return git_diff("changed", " ")
end

-- Vi mode

-- local vi_mode_alias = setmetatable({
--   ["n"] = "NORMAL",
--   ["no"] = "OP",
--   ["nov"] = "OP",
--   ["noV"] = "OP",
--   ["no"] = "OP",
--   ["niI"] = "NORMAL",
--   ["niR"] = "NORMAL",
--   ["niV"] = "NORMAL",
--   ["v"] = "VISUAL",
--   ["vs"] = "VISUAL",
--   ["V"] = "LINES",
--   ["Vs"] = "LINES",
--   [""] = "BLOCK",
--   ["s"] = "BLOCK",
--   ["s"] = "SELECT",
--   ["S"] = "SELECT",
--   [""] = "BLOCK",
--   ["i"] = "INSERT",
--   ["ic"] = "INSERT",
--   ["ix"] = "INSERT",
--   ["R"] = "REPLACE",
--   ["Rx"] = "REPLACE",
--   ["Rv"] = "V-REPLACE",
--   ["Rvc"] = "REPLACE",
--   ["Rvx"] = "REPLACE",
--   ["c"] = "COMMAND",
--   ["cv"] = "COMMAND",
--   ["ce"] = "COMMAND",
--   ["r"] = "ENTER",
--   ["rm"] = "MORE",
--   ["r?"] = "CONFIRM",
--   ["!"] = "SHELL",
--   ["t"] = "TERMINAL",
--   ["null"] = "NONE",
-- }, {
--   -- fix wired issues
--   __index = function(_, _)
--     return "UNKNOWN"
--   end,
-- })

local vi_mode_hlgroup = setmetatable({
  ["n"] = "Normal",
  ["v"] = "Visual",
  ["V"] = "Visual",
  [""] = "Visual",
  ["s"] = "Select",
  ["S"] = "Select",
  [""] = "Select",
  ["i"] = "Insert",
  ["R"] = "Replace",
  ["c"] = "Command",
}, {
  __index = function(_, _)
    return "Other"
  end,
})

local function vi_mode()
  local mode = vim.api.nvim_get_mode()["mode"]
  local m = string.sub(mode, 1, 1) -- get the leading character of vi mode
  local hl = vi_mode_hlgroup[m]
  return string.format("%%#StatuslineMode%s#▊", hl)
end

-- [ LSP status ]
-- LSP clients names
local function lsp_client_names(buffer)
  local clients = {}
  for _, client in pairs(vim.lsp.buf_get_clients(buffer.bufnr)) do
    clients[#clients + 1] = client.name
  end
  if #clients > 0 then
    return "  " .. table.concat(clients, "|")
  end
  return ""
end

-- LSP diagnostics info
local function get_diagnostics_count(bufnr, severity)
  return #vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity[severity] })
end

local function get_diagnostics(bufnr, severity, icon)
  local count = get_diagnostics_count(bufnr, severity)
  return count ~= 0 and string.format("%s%d", icon, count) or ""
end

local function diagnostics_errors(buffer)
  return get_diagnostics(buffer.bufnr, "ERROR", " ")
end

local function diagnostics_warnings(buffer)
  return get_diagnostics(buffer.bufnr, "WARN", " ")
end

local function diagnostics_info(buffer)
  return get_diagnostics(buffer.bufnr, "INFO", " ")
end

local function diagnostics_hints(buffer)
  return get_diagnostics(buffer.bufnr, "HINTS", " ")
end

-- [ Building statusline ]
local components_active = {
  left = {
    { provider = vi_mode, left_sep = "", right_sep = "" },
    { provider = file_icon, hl = "StatuslineFileIcon", left_sep = " ", right_sep = "" },
    { provider = file_name, hl = "StatuslineFileName", left_sep = " ", right_sep = "" },
    { provider = file_modified, hl = "StatuslineFileModified", left_sep = " ", right_sep = "" },
    { provider = file_readonly, hl = "StatuslineFileReadonly", left_sep = " ", right_sep = "" },
    { provider = git_branch, hl = "StatuslineGitBranch", left_sep = " ", right_sep = "" },
    { provider = git_diff_added, hl = "StatuslineDiffAdded", left_sep = " ", right_sep = "" },
    { provider = git_diff_removed, hl = "StatuslineDiffRemoved", left_sep = " ", right_sep = "" },
    { provider = git_diff_changed, hl = "StatuslineDiffModified", left_sep = " ", right_sep = "" },
  },
  middle = {
    { provider = lsp_client_names, hl = "StatuslineLspClient", left_sep = "", right_sep = "" },
    { provider = diagnostics_errors, hl = "StatuslineDiagnosticError", left_sep = " ", right_sep = "" },
    { provider = diagnostics_warnings, hl = "StatuslineDiagnosticWarning", left_sep = " ", right_sep = "" },
    { provider = diagnostics_info, hl = "StatuslineDiagnosticInfo", left_sep = " ", right_sep = "" },
    { provider = diagnostics_hints, hl = "StatuslineDiagnosticHint", left_sep = " ", right_sep = "" },
  },
  right = {
    { provider = file_size, hl = "StatuslineFileSize", left_sep = "", right_sep = " " },
    { provider = file_format, hl = "Statusline", left_sep = "", right_sep = " " },
    { provider = file_encoding, hl = "Statusline", left_sep = "", right_sep = " " },
    { provider = location, hl = "Statusline", left_sep = "", right_sep = " " },
    { provider = progress, hl = "Statusline", left_sep = "", right_sep = " " },
    { provider = vi_mode, left_sep = "", right_sep = "" },
  },
}

local function build_statusline(components)
  local results = {}
  for _, c in ipairs(components) do
    local body = c.provider()
    if #body > 0 then
      if c.hl ~= nil then
        table.insert(results, string.format("%%#%s#%s%s%s", c.hl, c.left_sep, body, c.right_sep))
      else
        table.insert(results, string.format("%s%s%s", c.left_sep, body, c.right_sep))
      end
    end
  end
  return table.concat(results, "")
end

--- Set option and autocmds for statusline
function M.setup()
  local group = vim.api.nvim_create_augroup("MyStatusline", { clear = true })
  vim.api.nvim_create_autocmd({ "VimEnter" }, {
    group = group,
    pattern = "*",
    callback = function()
      --vim.wo.statusline = require("rc.statusline").statusline()
      vim.o.statusline = "%!v:lua.require'rc.statusline'.statusline()"
    end,
    once = true,
    desc = "Set statusline (window option)",
  })
  vim.api.nvim_create_autocmd({ "VimResized", "FileChangedShellPost" }, {
    group = group,
    pattern = "*",
    command = "redrawstatus",
  })
end

--- Table to cache status line in each window (key: winid, value: statusline string)
M._statusline_win = {}

--- Construct strings for the statusline
function M.statusline()
  local winid = vim.g.statusline_winid
  if winid == vim.api.nvim_get_current_win() or M._statusline_win[winid] == nil then
    local bufnr = vim.api.nvim_win_get_buf(winid)
    local buffer = Buffer:new(bufnr)
    local left = build_statusline(components_active.left)
    local middle = build_statusline(components_active.middle)
    local right = build_statusline(components_active.right)
    M._statusline_win[winid] = left .. "%=" .. middle .. "%=" .. right
  end

  return M._statusline_win[winid]
end

return M
