local M = {}

-- [[ Components ]]

-- [ File info ]
local function file_readonly()
  return vim.bo.readonly and " " or ""
end

local function file_modified()
  if vim.tbl_contains({ "help", "denite", "fzf", "tagbar" }, vim.bo.filetype) then
    return ""
  end
  if vim.bo.modifiable then
    if vim.bo.modified then
      return " "
    end
  end
  return ""
end

local function file_icon()
  local ft = vim.bo.filetype
  if #ft > 0 then
    local ok, devicons = pcall(require, "nvim-web-devicons")
    if ok then
      local f_name = vim.fn.expand "%:t"
      local f_ext = vim.fn.expand "%:e"
      local icon = devicons.get_icon(f_name, f_ext)
      if icon ~= nil then
        return icon
      elseif ft == "help" then
        return ""
      end
    end
  end
  return ""
end

local function file_size()
  local file = vim.fn.expand "%:p"
  if string.len(file) == 0 then
    return ""
  end
  -- Format file size
  local size = vim.fn.getfsize(file)
  if size == 0 or size == -1 or size == -2 then
    return ""
  end
  local kb = 1024
  local mb = 1024 * 1024
  local gb = 1024 * 1024 * 1024
  if size < kb then
    size = size .. "B "
  elseif size < mb then
    size = string.format("%.1f%s", size / kb, "KiB")
  elseif size < gb then
    size = string.format("%.1f%s", size / mb, "MiB")
  else
    size = string.format("%.1f%s", size / gb, "GiB")
  end
  return size
end

local function file_name()
  local ft_lean = { "tagbar", "vista", "defx", "coc-explorer", "magit" }
  local ft = vim.bo.filetype
  if vim.tbl_contains(ft_lean, ft) then
    return " "
  end

  local name = vim.api.nvim_buf_get_name(0) -- full path
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
local function file_encoding()
  local fenc = vim.bo.fileencoding
  if fenc == "" then
    fenc = vim.o.encoding
  end
  return fenc
end

local function file_format()
  local ff = vim.bo.fileformat
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

-- [ Git info ]

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

-- -- Vi mode
-- local current_mode_label = setmetatable({
--   ["n"] = "NORMAL",
--   ["no"] = "NORMAL-OP",
--   ["v"] = "VISUAL",
--   ["V"] = "VISUAL-L",
--   [""] = "VISUAL-B",
--   ["s"] = "SELECT",
--   ["S"] = "SELECT-L",
--   [""] = "SELECT-B",
--   ["i"] = "INSERT",
--   ["ic"] = "INSERT",
--   ["ix"] = "INSERT",
--   ["R"] = "REPLACE",
--   ["Rv"] = "V-REPLACE",
--   ["c"] = "COMMAND",
--   ["cv"] = "VIM EX",
--   ["ce"] = "EX",
--   ["r"] = "PROMPT",
--   ["rm"] = "MORE",
--   ["r?"] = "CONFIRM",
--   ["!"] = "SHELL",
--   ["t"] = "TERMINAL",
-- }, {
--   -- fix wired issues
--   __index = function(_, _)
--     return "V-BLOCK"
--   end,
-- })

-- local current_mode_hi_groups = setmetatable({
--   ["n"] = "Normal",
--   ["i"] = "Insert",
--   ["v"] = "Visual",
--   ["V"] = "Visual",
--   [""] = "Visual",
--   ["R"] = "Replace",
--   ["Rv"] = "Replace",
--   ["c"] = "Command",
--   ["t"] = "Terminal",
-- }, {
--   __index = function(_, _)
--     return "Normal"
--   end,
-- })

-- local function vi_mode(inactive)
--   local mode = vim.api.nvim_get_mode()["mode"]
--   local label = current_mode_label[mode]
--   local hl = inactive and "NC" or current_mode_hi_groups[mode]
--   return string.format("%s%%#Statusline%s#%s%s", left_separator(hl), hl, label, right_separator(hl))
-- end

-- [ LSP status ]
local function lsp_client_names()
  local clients = {}
  for _, client in pairs(vim.lsp.buf_get_clients(0)) do
    clients[#clients + 1] = client.name
  end
  if #clients > 0 then
    return "  " .. table.concat(clients, "|")
  end
  return ""
end

local function get_diagnostics_count(severity)
  local active_clients = vim.lsp.buf_get_clients(0)
  if not active_clients then
    return 0
  end
  local count = 0
  for _, client in pairs(active_clients) do
    count = count + vim.lsp.diagnostic.get_count(0, severity, client.id)
  end
  return count
end

local function get_diagnostics(severity, icon)
  local count = get_diagnostics_count(severity)
  return count ~= 0 and string.format("%s%d", icon, count) or ""
end

local function diagnostics_errors()
  return get_diagnostics("Error", " ")
end

local function diagnostics_warnings()
  return get_diagnostics("Warning", " ")
end

local function diagnostics_info()
  return get_diagnostics("Warning", " ")
end

local function diagnostics_hints()
  return get_diagnostics("Warning", " ")
end

-- [ Building statusline ]
local components_active = {
  left = {
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
  },
}

local components_inactive = {
  left = {
    { provider = file_name, hl = "StatuslineNC", left_sep = " ", right_sep = " " },
  },
  right = {
    { provider = location, hl = "StatuslineNC", left_sep = " ", right_sep = " " },
    { provider = progress, hl = "StatuslineNC", left_sep = " ", right_sep = " " },
  },
}

local function build_statusline(components)
  local results = {}
  for _, c in ipairs(components) do
    local body = c.provider()
    if #body > 0 then
      table.insert(results, string.format("%%#%s#%s%s%s", c.hl, c.left_sep, body, c.right_sep))
    end
  end
  return table.concat(results, "")
end

local function set_statusline()
  vim.o.statusline = "%!v:lua.require'rc.statusline'.statusline()"
  vim.api.nvim_exec(
    [[
      augroup MyStatusline
      autocmd!
      autocmd WinLeave,BufLeave * lua vim.wo.statusline=require'rc.statusline'.statusline()
      autocmd BufWinEnter,WinEnter,BufEnter,TermOpen * set statusline<
      autocmd VimResized,FileChangedShellPost * redrawstatus
      augroup END
    ]],
    false
  )
end

--- Set option and autocmds for statusline
function M.setup()
  set_statusline()
end

--- Construct strings for the statusline
function M.statusline()
  local left, middle, right
  if vim.g.statusline_winid == vim.fn.win_getid() then
    left = build_statusline(components_active.left)
    middle = build_statusline(components_active.middle)
    right = build_statusline(components_active.right)
    return left .. "%=" .. middle .. "%=" .. right
  else
    left = build_statusline(components_inactive.left)
    right = build_statusline(components_inactive.right)
    return left .. "%=" .. right
  end
end

return M
