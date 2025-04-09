local M = {}

local get_default_palette = function()
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
    -- lsp clients
    lsp = utils.get_highlight("String").fg,
    -- cwd
    cwd = utils.get_highlight("Number").fg,
    -- ruler
    ruler = utils.get_highlight("Identifier").fg,
  }
end

local color_palette = {}

color_palette.catppuccin = function()
  local flavour = require("catppuccin").flavour
  local C = require("catppuccin.palettes").get_palette(flavour)
  return {
    -- forground colors
    fg = C.subtext1,
    fg_dim = C.subtext0,
    fg_bright = C.text,
    -- background colors
    bg = C.mantle,
    bg_bright = C.surface0,
    bg_bright_2 = C.surface1,
    -- terminal colors
    black = C.overlay0,
    red = C.red,
    green = C.green,
    yellow = C.yellow,
    blue = C.blue,
    magenta = C.pink,
    cyan = C.sky,
    white = C.text,
    black_bright = C.overlay1,
    red_bright = C.red,
    green_bright = C.green,
    yellow_bright = C.yellow,
    blue_bright = C.blue,
    magenta_bright = C.pink,
    cyan_bright = C.sky,
    white_bright = C.text,
    -- diagnostics
    diag_error = C.red,
    diag_warn = C.yellow,
    diag_info = C.sky,
    diag_hint = C.teal,
    diag_ok = C.green,
    -- git
    git_add = C.green,
    git_delete = C.red,
    git_change = C.blue,
    -- lsp clients
    lsp = C.green,
    -- cwd
    cwd = C.lavender,
    -- ruler
    ruler = C.flamingo,
  }
  -- return {
  -- 	rosewater = "#f5e0dc",
  -- 	flamingo = "#f2cdcd",
  -- 	pink = "#f5c2e7",
  -- 	mauve = "#cba6f7",
  -- 	red = "#f38ba8",
  -- 	maroon = "#eba0ac",
  -- 	peach = "#fab387",
  -- 	yellow = "#f9e2af",
  -- 	green = "#a6e3a1",
  -- 	teal = "#94e2d5",
  -- 	sky = "#89dceb",
  -- 	sapphire = "#74c7ec",
  -- 	blue = "#89b4fa",
  -- 	lavender = "#b4befe",
  -- 	text = "#cdd6f4",
  -- 	subtext1 = "#bac2de",
  -- 	subtext0 = "#a6adc8",
  -- 	overlay2 = "#9399b2",
  -- 	overlay1 = "#7f849c",
  -- 	overlay0 = "#6c7086",
  -- 	surface2 = "#585b70",
  -- 	surface1 = "#45475a",
  -- 	surface0 = "#313244",
  -- 	base = "#1e1e2e",
  -- 	mantle = "#181825",
  -- 	crust = "#11111b",
  -- }
end

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
  local theme = vim.g.colors_name
  for _, name in ipairs { "catppuccin", "kanagawa" } do
    if string.match(theme, "^" .. name) then
      theme = name
    end
  end
  local p = color_palette[theme]
  if p ~= nil then
    return p()
  end
  return get_default_palette()
end

return M
