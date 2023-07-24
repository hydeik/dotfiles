local M = {}

--- Blend two rgb colors using alpha
---@param color1 string | number first color
---@param color2 string | number second color
---@param alpha number (0, 1) float determining the weighted average
---@return string color hex string of the blended color
M.blend = function(color1, color2, alpha)
  color1 = type(color1) == "number" and string.format("#%06x", color1) or color1
  color2 = type(color2) == "number" and string.format("#%06x", color2) or color2
  local r1, g1, b1 = color1:match "#(%x%x)(%x%x)(%x%x)"
  local r2, g2, b2 = color2:match "#(%x%x)(%x%x)(%x%x)"
  local r = tonumber(r1, 16) * alpha + tonumber(r2, 16) * (1 - alpha)
  local g = tonumber(g1, 16) * alpha + tonumber(g2, 16) * (1 - alpha)
  local b = tonumber(b1, 16) * alpha + tonumber(b2, 16) * (1 - alpha)
  return "#"
    .. string.format("%02x", math.min(255, math.max(r, 0)))
    .. string.format("%02x", math.min(255, math.max(g, 0)))
    .. string.format("%02x", math.min(255, math.max(b, 0)))
end

--- Generate dim color
---@param color string | number original color
---@param alpha number (0, 1) float determining the weighted average
M.dim = function(color, alpha)
  return M.blend(color, "#000000", alpha)
end

M.setup_colors = function()
  local utils = require "heirline.utils"
  return {
    -- forground colors
    fg = utils.get_highlight("StatusLine").fg,
    fg_dim = utils.get_highlight("StatusLineNC").fg,
    fg_bright = utils.get_highlight("Folded").fg,
    -- background colors
    bg = utils.get_highlight("StatusLine").bg,
    bg_bright = utils.get_highlight("Folded").bg,
    bg_bright_2 = utils.get_highlight("CursorLine").bg,
    -- terminal colors
    black = vim.g.terminal_color_0,
    red = vim.g.terminal_color_1,
    green = vim.g.terminal_color_2,
    yellow = vim.g.terminal_color_3,
    blue = vim.g.terminal_color_4,
    magenta = vim.g.terminal_color_5,
    cyan = vim.g.terminal_color_6,
    white = vim.g.terminal_color_7,
    black_bright = vim.g.terminal_color_8,
    red_bright = vim.g.terminal_color_9,
    green_bright = vim.g.terminal_color_10,
    yellow_bright = vim.g.terminal_color_11,
    blue_bright = vim.g.terminal_color_12,
    magenta_bright = vim.g.terminal_color_13,
    cyan_bright = vim.g.terminal_color_14,
    white_bright = vim.g.terminal_color_15,
    -- diagnostics
    diag_error = utils.get_highlight("DiagnosticError").fg,
    diag_warn = utils.get_highlight("DiagnosticWarn").fg,
    diag_info = utils.get_highlight("DiagnosticInfo").fg,
    diag_hint = utils.get_highlight("DiagnosticHint").fg,
    diag_ok = utils.get_highlight("DiagnosticOk").fg,
    -- git
    git_add = utils.get_highlight("diffAdded").fg,
    git_delete = utils.get_highlight("diffDeleted").fg,
    git_change = utils.get_highlight("diffChanged").fg,
  }
end

return M
