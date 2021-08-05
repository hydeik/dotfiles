local utils = require "utils"

local conf = {
  style = utils.get_var("edge_style", "default"),
  transparent_background = utils.get_var("edge_transparent_background", 0),
}

local colors
if conf.style == "aura" then
  colors = {
    bg0 = { "#2b2d37", 235 },
    bg1 = { "#2f323e", 236 },
    bg2 = { "#363a49", 237 },
    bg3 = { "#3a3e4e", 237 },
    bg4 = { "#404455", 238 },
    bg_grey = { "#7e869b", 246 },
    bg_red = { "#ec7279", 203 },
    diff_red = { "#55393d", 52 },
    bg_green = { "#a0c980", 107 },
    diff_green = { "#394634", 22 },
    bg_blue = { "#6cb6eb", 110 },
    diff_blue = { "#354157", 17 },
    bg_purple = { "#d38aea", 176 },
    diff_yellow = { "#4e432f", 54 },
    fg = { "#c5cdd9", 250 },
    red = { "#ec7279", 203 },
    yellow = { "#deb974", 179 },
    green = { "#a0c980", 107 },
    cyan = { "#5dbbc1", 72 },
    blue = { "#6cb6eb", 110 },
    purple = { "#d38aea", 176 },
    grey = { "#7e8294", 246 },
    none = { "NONE", "NONE" },
  }
elseif conf.style == "neon" then
  colors = {
    bg0 = { "#2b2d3a", 235 },
    bg1 = { "#2f3242", 236 },
    bg2 = { "#363a4e", 237 },
    bg3 = { "#393e53", 237 },
    bg4 = { "#3f445b", 238 },
    bg_grey = { "#7a819d", 246 },
    bg_red = { "#ec7279", 203 },
    diff_red = { "#55393d", 52 },
    bg_green = { "#a0c980", 107 },
    diff_green = { "#394634", 22 },
    bg_blue = { "#6cb6eb", 110 },
    diff_blue = { "#354157", 17 },
    bg_purple = { "#d38aea", 176 },
    diff_yellow = { "#4e432f", 54 },
    fg = { "#c5cdd9", 250 },
    red = { "#ec7279", 203 },
    yellow = { "#deb974", 179 },
    green = { "#a0c980", 107 },
    cyan = { "#5dbbc1", 72 },
    blue = { "#6cb6eb", 110 },
    purple = { "#d38aea", 176 },
    grey = { "#7e8294", 246 },
    none = { "NONE", "NONE" },
  }
else -- conf.style == "default"
  colors = {
    bg0 = { "#2c2e34", 235 },
    bg1 = { "#30323a", 236 },
    bg2 = { "#363944", 237 },
    bg3 = { "#3b3e48", 237 },
    bg4 = { "#414550", 238 },
    bg_grey = { "#828a98", 246 },
    bg_red = { "#ec7279", 203 },
    diff_red = { "#55393d", 52 },
    bg_green = { "#a0c980", 107 },
    diff_green = { "#394634", 22 },
    bg_blue = { "#6cb6eb", 110 },
    diff_blue = { "#354157", 17 },
    bg_purple = { "#d38aea", 176 },
    diff_yellow = { "#4e432f", 54 },
    fg = { "#c5cdd9", 250 },
    red = { "#ec7279", 203 },
    yellow = { "#deb974", 179 },
    green = { "#a0c980", 107 },
    cyan = { "#5dbbc1", 72 },
    blue = { "#6cb6eb", 110 },
    purple = { "#d38aea", 176 },
    grey = { "#7f8490", 246 },
    none = { "NONE", "NONE" },
  }
end

local theme = {
  -- base
  Base = {
    fg = colors.fg,
    bg = conf.transparent_background and colors.none or colors.bg1,
  },
  Inactive = { fg = colors.grey, bg = colors.bg1 },

  -- vi mode
  Normal = { fg = colors.black, bg = colors.bg_blue, attr = "bold" },
  Insert = { fg = colors.black, bg = colors.bg_green, attr = "bold" },
  Visual = { fg = colors.black, bg = colors.bg_purple, attr = "bold" },
  Replace = { fg = colors.black, bg = colors.orange, attr = "bold" },
  Command = { fg = colors.black, bg = colors.yellow, attr = "bold" },
  Terminal = { fg = colors.black, bg = colors.bg_red, attr = "bold" },

  -- file
  FileIcon = { fg = colors.blue, bg = colors.bg4 },
  FileName = { fg = colors.fg, bg = colors.bg4 },
  FileModified = { fg = colors.orange, bg = colors.bg1 },
  FileReadonly = { fg = colors.red, bg = colors.bg1 },
  FileSize = { fg = colors.green, bg = colors.bg1 },
  FileFormat = { fg = colors.fg, bg = colors.bg1 },
  FileEncoding = { fg = colors.fg, bg = colors.bg1 },

  -- line/column info
  LineColumn = { fg = colors.fg, bg = colors.bg4 },
  LinePercent = { fg = colors.fg, bg = colors.bg4 },

  -- git
  BranchIcon = { fg = colors.purple, bg = colors.bg0 },
  BranchName = { fg = colors.fg, bg = colors.bg0 },

  -- diff
  DiffAdded = { fg = colors.green, bg = colors.bg0 },
  DiffModified = { fg = colors.yellow, bg = colors.bg0 },
  DiffRemoved = { fg = colors.red, bg = colors.bg0 },

  -- LSP
  NearestSymbol = { fg = colors.purple, bg = colors.bg0 },

  -- diagnostic
  -- DiagnosticError   = { fg = colors.red,    bg = colors.bg0 },
  -- DiagnosticWarning = { fg = colors.yellow, bg = colors.bg0 },
  -- DiagnosticInfo    = { fg = colors.blue,   bg = colors.bg0 },
  -- DiagnosticHint    = { fg = colors.green,  bg = colors.bg0 },

  DiagnosticInfo = { fg = colors.black, bg = colors.bg_blue },
  DiagnosticHint = { fg = colors.black, bg = colors.bg_green },
}

return theme
