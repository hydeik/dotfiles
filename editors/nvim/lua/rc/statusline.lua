local M = {}

-- [[ Components ]]

-- File info
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

-- -- File info
-- local function file_readonly(inactive)
--   if vim.bo.filetype == "help" then
--     return ""
--   end
--   local hl = inactive and "Inactive" or "FileReadonly"
--   if vim.bo.readonly then
--     return string.format("%%#StatusLine%s# ", hl)
--   else
--     return ""
--   end
-- end

-- local function file_modified(inactive)
--   if vim.tbl_contains({ "help", "denite", "fzf", "tagbar" }, vim.bo.filetype) then
--     return ""
--   end
--   local hl = inactive and "Inactive" or "FileModified"
--   if vim.bo.modifiable then
--     if vim.bo.modified then
--       return string.format("%%#StatusLine%s#  ", hl)
--     end
--   end
--   return ""
-- end

-- local function file_icon(inactive)
--   local hl = inactive and "Inactive" or "FileIcon"
--   local ft = vim.bo.filetype
--   if #ft > 0 then
--     local ok, devicons = pcall(require, "nvim-web-devicons")
--     if ok then
--       local f_name = vim.fn.expand "%:t"
--       local f_ext = vim.fn.expand "%:e"
--       local icon = devicons.get_icon(f_name, f_ext)
--       if icon ~= nil then
--         return string.format("%%#StatusLine%s#%s", hl, icon)
--       elseif ft == "help" then
--         return string.format("%%#StatusLine%s#", hl)
--       end
--     end
--   end
--   return ""
-- end

-- local function file_size(inactive)
--   local file = vim.fn.expand "%:p"
--   if string.len(file) == 0 then
--     return ""
--   end
--   -- Format file size
--   local hl = inactive and "Inactive" or "FileSize"
--   local size = vim.fn.getfsize(file)
--   if size == 0 or size == -1 or size == -2 then
--     return ""
--   end
--   local kb = 1024
--   local mb = 1024 * 1024
--   local gb = 1024 * 1024 * 1024
--   if size < kb then
--     size = size .. "b "
--   elseif size < mb then
--     size = string.format("%.1f%s", size / kb, "k ")
--   elseif size < gb then
--     size = string.format("%.1f%s", size / mb, "m ")
--   else
--     size = string.format("%.1f%s", size / gb, "g ")
--   end
--   return string.format("%%#StatusLine%s# %s", hl, size)
-- end

-- local function file_name(inactive)
--   local ft_lean = { "tagbar", "vista", "defx", "coc-explorer", "magit" }
--   local ft = vim.bo.filetype
--   if vim.tbl_contains(ft_lean, ft) then
--     return " "
--   end

--   local hl = inactive and "Inactive" or "FileName"
--   local name = vim.api.nvim_buf_get_name(0) -- full path
--   if name == "" then
--     name = "[No Name]"
--   else
--     name = vim.fn.fnamemodify(name, ":.") -- path relative to current directory
--     if #name > 24 then
--       name = vim.fn.pathshorten(name)
--     end
--   end

--   return string.format("%%#StatusLine%s# %s ", hl, name)
-- end

-- local function file_info(inactive)
--   local hl_left = inactive and "Inactive" or "FileIcon"
--   local hl_right = inactive and "Inactive" or "FileName"

--   local s1 = left_separator(hl_left)
--   s1 = s1 .. file_icon(inactive)
--   s1 = s1 .. file_name(inactive)
--   local s2 = file_modified(inactive)
--   s2 = s2 .. file_readonly(inactive)
--   s2 = s2 .. file_size(inactive)
--   if #s2 > 0 and not inactive then
--     hl_right = "FileSize"
--   end
--   s2 = s2 .. right_separator(hl_right)
--   return s1 .. s2
-- end

-- -- file encoding & format
-- local function file_encoding(inactive)
--   local fenc = vim.bo.fileencoding
--   if fenc == "" then
--     fenc = vim.o.encoding
--   end
--   local hl = inactive and "Inactive" or "FileEncoding"
--   return string.format("%%#StatusLine%s# %s", hl, fenc)
-- end

-- local function file_format(inactive)
--   local ff = vim.bo.fileformat
--   local hl = inactive and "Inactive" or "FileFormat"
--   local icon
--   if ff == "mac" then
--     icon = " "
--   elseif ff == "unix" then
--     icon = " "
--   elseif ff == "dos" then
--     icon = " "
--   end
--   return string.format("%%#StatusLine%s# %s", hl, icon)
-- end

-- local function file_encoding_and_format(inactive)
--   local hl_left = inactive and "Inactive" or "FileEncoding"
--   local hl_right = inactive and "Inactive" or "FileFormat"
--   local s = left_separator(hl_left)
--   s = s .. file_encoding(inactive)
--   s = s .. file_format(inactive)
--   s = s .. right_separator(hl_right)
--   return s
-- end

-- -- Lines/columns
-- local function line_colmun_info(inactive)
--   local hl = inactive and "Inactive" or "LineColumn"
--   return string.format("%s%%#StatusLine%s#  %%3l/%%L  %%-2v%s", left_separator(hl), hl, right_separator(hl))
-- end

-- -- VCS
-- local function git_info(inactive)
--   if not inactive then
--     local icon = {
--       branch = " ",
--       diff_added = " ",
--       diff_removed = " ",
--       diff_modified = " ",
--     }
--     local ok, data = pcall(vim.api.nvim_buf_get_var, 0, "gitsigns_status_dict")
--     if ok then
--       local s = "%#StatusLineBranchIconSep#" .. separator.left
--       s = s .. "%#StatusLineBranchIcon#" .. icon.branch
--       s = s .. "%#StatusLineBranchName#" .. data.head
--       local hl_right = "BranchName"
--       if data.added ~= nil and data.added > 0 then
--         s = s .. " %#StatusLineDiffAdded#" .. icon.diff_added .. data.added
--         hl_right = "DiffAdded"
--       end
--       if data.changed ~= nil and data.changed > 0 then
--         s = s .. " %#StatusLineDiffModified#" .. icon.diff_modified .. data.changed
--         hl_right = "DiffModified"
--       end
--       if data.removed ~= nil and data.removed > 0 then
--         s = s .. " %#StatusLineDiffRemoved#" .. icon.diff_removed .. data.removed
--         hl_right = "DiffRemoved"
--       end
--       s = s .. string.format("%%#StatusLine%sSep#%s", hl_right, separator.right)
--       return s
--     end
--   end
--   return ""
-- end

-- -- LSP status
-- local function diagnostic_info(inactive)
--   if inactive or #vim.lsp.buf_get_clients(0) == 0 then
--     return ""
--   end
--   local active_clients = vim.lsp.get_active_clients()

--   if active_clients then
--     local levels = {
--       error = "Error",
--       warn = "Warning",
--       info = "Information",
--       hint = "Hint",
--     }
--     local icons = { error = " ", warn = " ", info = " ", hint = " " }
--     local data = {}
--     local bufnr = vim.api.nvim_get_current_buf()
--     for k, level in pairs(levels) do
--       local count = 0
--       for _, client in ipairs(active_clients) do
--         count = count + vim.lsp.diagnostic.get_count(bufnr, level, client.id)
--       end
--       data[k] = count
--     end

--     local s = ""
--     local hl_left, hl_right
--     if data.error ~= nil and data.error > 0 then
--       if not hl_left then
--         hl_left = "DiagnosticError"
--       end
--       s = s .. string.format("%%#StatusLineDiagnosticError# %s %s ", icons.error, data.error)
--       hl_right = "DiagnosticError"
--     end
--     if data.warn ~= nil and data.warn > 0 then
--       if not hl_left then
--         hl_left = "DiagnosticWarning"
--       end
--       s = s .. string.format("%%#StatusLineDiagnosticWarning# %s %s ", icons.warn, data.warn)
--       hl_right = "DiagnosticWarning"
--     end
--     if data.info ~= nil and data.info > 0 then
--       if not hl_left then
--         hl_left = "DiagnosticInfo"
--       end
--       s = s .. string.format("%%#StatusLineDiagnosticInfo# %s %s ", icons.info, data.info)
--       hl_right = "DiagnosticInfo"
--     end
--     if data.hint ~= nil and data.hint > 0 then
--       if not hl_left then
--         hl_left = "DiagnosticHint"
--       end
--       s = s .. string.format("%%#StatusLineDiagnosticHint# %s %s ", icons.hint, data.hint)
--       hl_right = "DiagnosticHint"
--     end
--     if #s > 0 then
--       return string.format("%s%s%s", left_separator(hl_left), s, right_separator(hl_right))
--     end
--   end
--   return ""
-- end

-- -- [[ Utility functions ]]

-- -- Colors
-- local function highlight(group, guifg, guibg, attr)
--   local parts = { group }
--   if guifg then
--     table.insert(parts, "guifg=" .. guifg)
--   end
--   if guibg then
--     table.insert(parts, "guibg=" .. guibg)
--   end
--   if attr then
--     table.insert(parts, "gui=" .. attr)
--     table.insert(parts, "cterm=" .. attr)
--   end
--   -- if guisp then table.insert(parts, "guisp=#"..guisp) end
--   vim.cmd("highlight " .. table.concat(parts, " "))
-- end

-- local function apply_theme()
--   if type(M.theme) == "string" then
--     M.theme = require("appearance.themes." .. M.theme)
--   end
--   local base_bg = M.theme["Base"].bg
--   for group, colors in pairs(M.theme) do
--     highlight("StatusLine" .. group, colors.fg, colors.bg, colors.attr)
--     if group ~= "Base" then
--       highlight("StatusLine" .. group .. "Sep", colors.bg, base_bg, nil)
--     end
--   end
--   theme_set = M.theme
-- end

-- -- build statusline
-- local function make_statusline(inactive)
--   if M.theme ~= theme_set then
--     apply_theme()
--   end
--   inactive = inactive or false
--   local space = "%#StatusLineBase# "
--   local s = space
--   s = s .. vi_mode(inactive)
--   s = s .. space
--   s = s .. file_info(inactive)
--   s = s .. space
--   s = s .. git_info(inactive)
--   s = s .. space
--   s = s .. "%="
--   s = s .. diagnostic_info(inactive)
--   s = s .. space
--   if vim.api.nvim_win_get_width(0) > 80 then
--     s = s .. file_encoding_and_format(inactive)
--     s = s .. space
--   end
--   s = s .. line_colmun_info(inactive)
--   s = s .. space
--   return s
-- end

-- -- Create augroup for updating statusline
-- local function statusline_augroup()
--   _G.statusline_active = require("appearance.statusline").statusline_active
--   _G.statusline_inactive = require("appearance.statusline").statusline_inactive

--   vim.cmd [[
--     augroup statusline_autocmd
--     autocmd!
--     autocmd VimEnter,ColorScheme * lua require'appearance.statusline'.statusline_apply_theme()
--     autocmd WinLeave,BufLeave * setlocal statusline=%!v:lua.statusline_inactive()
--     autocmd BufWinEnter,WinEnter,BufEnter,TermOpen * setlocal statusline=%!v:lua.statusline_active()
--     autocmd VimResized,BufWritePost,FileChangedShellPost * redrawstatus
--     augroup END
--   ]]
-- end

-- -- [[ API ]]
-- function M.statusline_active()
--   return make_statusline(false)
-- end

-- function M.statusline_inactive()
--   return make_statusline(true)
-- end

-- M.statusline_apply_theme = apply_theme

-- function M.setup(theme_name)
--   M.theme = theme_name
--   statusline_augroup()
-- end

-- [ Building statusline ]
local components_active = {
  left = {
    { provider = file_icon, hl = "StatuslineFileIcon", left_sep = " ", right_sep = "" },
    { provider = file_name, hl = "StatuslineFileName", left_sep = " ", right_sep = "" },
    { provider = file_modified, hl = "StatuslineFileModified", left_sep = " ", right_sep = "" },
    { provider = file_readonly, hl = "StatuslineFileReadonly", left_sep = " ", right_sep = "" },
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

-- Entry point for setting statusline
function M.setup()
  set_statusline()
end

function M.statusline()
  local left, right
  if vim.g.statusline_winid == vim.fn.win_getid() then
    left = build_statusline(components_active.left)
    right = build_statusline(components_active.right)
  else
    left = build_statusline(components_inactive.left)
    right = build_statusline(components_inactive.right)
  end
  return left .. "%=" .. right
end

return M
