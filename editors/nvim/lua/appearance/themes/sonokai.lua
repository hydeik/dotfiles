local utils = require("utils")

local conf = {
  style = utils.get_var("sonokai_style", "default"),
  transparent_background = utils.get_var("sonokai_transparent_background", 0),
}

local colors
if conf.style == "shusia" then
  colors = {
    black = "#1a181a",
    bg0 = "#2d2a2e",
    bg1 = "#343136",
    bg2 = "#3b383e",
    bg3 = "#423f46",
    bg4 = "#49464e",
    bg_red = "#ff6188",
    diff_red = "#55393d",
    bg_green = "#a9dc76",
    diff_green = "#394634",
    bg_blue = "#78dce8",
    diff_blue = "#354157",
    diff_yellow = "#4e432f",
    fg = "#e3e1e4",
    red = "#f85e84",
    orange = "#ef9062",
    yellow = "#e5c463",
    green = "#9ecd6f",
    blue = "#7accd7",
    purple = "#ab9df2",
    grey = "#848089",
    none = "NONE",
  }
elseif conf.style == "andromeda" then
  colors = {
    black = "#181a1c",
    bg0 = "#2b2d3a",
    bg1 = "#2f3242",
    bg2 = "#363a4e",
    bg3 = "#393e53",
    bg4 = "#3f445b",
    bg_red = "#ff6188",
    diff_red = "#55393d",
    bg_green = "#a9dc76",
    diff_green = "#394634",
    bg_blue = "#77d5f0",
    diff_blue = "#354157",
    diff_yellow = "#4e432f",
    fg = "#e1e3e4",
    red = "#fb617e",
    orange = "#f89860",
    yellow = "#edc763",
    green = "#9ed06c",
    blue = "#6dcae8",
    purple = "#bb97ee",
    grey = "#7e8294",
    none = "NONE",
  }
elseif conf.style == "atlantis" then
  colors = {
    black = "#181a1c",
    bg0 = "#2a2f38",
    bg1 = "#303541",
    bg2 = "#373c4b",
    bg3 = "#3d4455",
    bg4 = "#424b5b",
    bg_red = "#ff6d7e",
    diff_red = "#55393d",
    bg_green = "#a5e179",
    diff_green = "#394634",
    bg_blue = "#7ad5f1",
    diff_blue = "#354157",
    diff_yellow = "#4e432f",
    fg = "#e1e3e4",
    red = "#ff6578",
    orange = "#f69c5e",
    yellow = "#eacb64",
    green = "#9dd274",
    blue = "#72cce8",
    purple = "#ba9cf3",
    grey = "#828a9a",
    none = "NONE",
  }
elseif conf.style == "maia" then
  colors = {
    black = "#1c1e1f",
    bg0 = "#273136",
    bg1 = "#2e383e",
    bg2 = "#353f46",
    bg3 = "#3a444b",
    bg4 = "#414b53",
    bg_red = "#ff6d7e",
    diff_red = "#55393d",
    bg_green = "#a2e57b",
    diff_green = "#394634",
    bg_blue = "#7cd5f1",
    diff_blue = "#354157",
    diff_yellow = "#4e432f",
    fg = "#e1e2e3",
    red = "#f76c7c",
    orange = "#f3a96a",
    yellow = "#e3d367",
    green = "#9cd57b",
    blue = "#78cee9",
    purple = "#baa0f8",
    grey = "#82878b",
    none = "NONE",
  }
else -- conf.style == "default"
  colors = {
    black = "#181819",
    bg0 = "#2c2e34",
    bg1 = "#30323a",
    bg2 = "#363944",
    bg3 = "#3b3e48",
    bg4 = "#414550",
    bg_red = "#ff6077",
    diff_red = "#55393d",
    bg_green = "#a7df78",
    diff_green = "#394634",
    bg_blue = "#85d3f2",
    diff_blue = "#354157",
    diff_yellow = "#4e432f",
    fg = "#e2e2e3",
    red = "#fc5d7c",
    orange = "#f39660",
    yellow = "#e7c664",
    green = "#9ed072",
    blue = "#76cce0",
    purple = "#b39df3",
    grey = "#7f8490",
    none = "NONE",
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
  DiagnosticError = { fg = colors.black, bg = colors.bg_red },
  DiagnosticWarning = { fg = colors.black, bg = colors.yellow },
  DiagnosticInfo = { fg = colors.black, bg = colors.bg_blue },
  DiagnosticHint = { fg = colors.black, bg = colors.bg_green },
}

return theme
