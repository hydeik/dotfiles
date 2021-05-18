local utils = require("utils")

local conf = {
  style = utils.get_var("tokyonight_style", "storm"),
  transparent_background = utils.get_var("tokyonight_transparent_background", 0),
}

local colors
if conf.style == "shusia" then
  colors = {
    black = { "#1a181a", 237 },
    bg0 = { "#2d2a2e", 235 },
    bg1 = { "#343136", 236 },
    bg2 = { "#3b383e", 236 },
    bg3 = { "#423f46", 237 },
    bg4 = { "#49464e", 237 },
    bg_red = { "#ff6188", 203 },
    diff_red = { "#55393d", 52 },
    bg_green = { "#a9dc76", 107 },
    diff_green = { "#394634", 22 },
    bg_blue = { "#78dce8", 110 },
    diff_blue = { "#354157", 17 },
    diff_yellow = { "#4e432f", 54 },
    fg = { "#e3e1e4", 250 },
    red = { "#f85e84", 203 },
    orange = { "#ef9062", 215 },
    yellow = { "#e5c463", 179 },
    green = { "#9ecd6f", 107 },
    blue = { "#7accd7", 110 },
    purple = { "#ab9df2", 176 },
    grey = { "#848089", 246 },
    none = { "NONE", "NONE" },
  }
elseif conf.style == "andromeda" then
  colors = {
    black = { "#181a1c", 237 },
    bg0 = { "#2b2d3a", 235 },
    bg1 = { "#2f3242", 236 },
    bg2 = { "#363a4e", 236 },
    bg3 = { "#393e53", 237 },
    bg4 = { "#3f445b", 237 },
    bg_red = { "#ff6188", 203 },
    diff_red = { "#55393d", 52 },
    bg_green = { "#a9dc76", 107 },
    diff_green = { "#394634", 22 },
    bg_blue = { "#77d5f0", 110 },
    diff_blue = { "#354157", 17 },
    diff_yellow = { "#4e432f", 54 },
    fg = { "#e1e3e4", 250 },
    red = { "#fb617e", 203 },
    orange = { "#f89860", 215 },
    yellow = { "#edc763", 179 },
    green = { "#9ed06c", 107 },
    blue = { "#6dcae8", 110 },
    purple = { "#bb97ee", 176 },
    grey = { "#7e8294", 246 },
    none = { "NONE", "NONE" },
  }
elseif conf.style == "atlantis" then
  colors = {
    black = { "#181a1c", 237 },
    bg0 = { "#2a2f38", 235 },
    bg1 = { "#303541", 236 },
    bg2 = { "#373c4b", 236 },
    bg3 = { "#3d4455", 237 },
    bg4 = { "#424b5b", 237 },
    bg_red = { "#ff6d7e", 203 },
    diff_red = { "#55393d", 52 },
    bg_green = { "#a5e179", 107 },
    diff_green = { "#394634", 22 },
    bg_blue = { "#7ad5f1", 110 },
    diff_blue = { "#354157", 17 },
    diff_yellow = { "#4e432f", 54 },
    fg = { "#e1e3e4", 250 },
    red = { "#ff6578", 203 },
    orange = { "#f69c5e", 215 },
    yellow = { "#eacb64", 179 },
    green = { "#9dd274", 107 },
    blue = { "#72cce8", 110 },
    purple = { "#ba9cf3", 176 },
    grey = { "#828a9a", 246 },
    none = { "NONE", "NONE" },
  }
elseif conf.style == "maia" then
  colors = {
    black = { "#1c1e1f", 237 },
    bg0 = { "#273136", 235 },
    bg1 = { "#2e383e", 236 },
    bg2 = { "#353f46", 236 },
    bg3 = { "#3a444b", 237 },
    bg4 = { "#414b53", 237 },
    bg_red = { "#ff6d7e", 203 },
    diff_red = { "#55393d", 52 },
    bg_green = { "#a2e57b", 107 },
    diff_green = { "#394634", 22 },
    bg_blue = { "#7cd5f1", 110 },
    diff_blue = { "#354157", 17 },
    diff_yellow = { "#4e432f", 54 },
    fg = { "#e1e2e3", 250 },
    red = { "#f76c7c", 203 },
    orange = { "#f3a96a", 215 },
    yellow = { "#e3d367", 179 },
    green = { "#9cd57b", 107 },
    blue = { "#78cee9", 110 },
    purple = { "#baa0f8", 176 },
    grey = { "#82878b", 246 },
    none = { "NONE", "NONE" },
  }
else -- conf.style == "default"
  colors = {
    black = { "#181819", 237 },
    bg0 = { "#2c2e34", 235 },
    bg1 = { "#30323a", 236 },
    bg2 = { "#363944", 236 },
    bg3 = { "#3b3e48", 237 },
    bg4 = { "#414550", 237 },
    bg_red = { "#ff6077", 203 },
    diff_red = { "#55393d", 52 },
    bg_green = { "#a7df78", 107 },
    diff_green = { "#394634", 22 },
    bg_blue = { "#85d3f2", 110 },
    diff_blue = { "#354157", 17 },
    diff_yellow = { "#4e432f", 54 },
    fg = { "#e2e2e3", 250 },
    red = { "#fc5d7c", 203 },
    orange = { "#f39660", 215 },
    yellow = { "#e7c664", 179 },
    green = { "#9ed072", 107 },
    blue = { "#76cce0", 110 },
    purple = { "#b39df3", 176 },
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
  Visual = { fg = colors.black, bg = colors.purple, attr = "bold" },
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

  DiagnosticError = { fg = colors.black, bg = colors.bg_red },
  DiagnosticWarning = { fg = colors.black, bg = colors.yellow },
  DiagnosticInfo = { fg = colors.black, bg = colors.bg_blue },
  DiagnosticHint = { fg = colors.black, bg = colors.bg_green },
}

return theme
