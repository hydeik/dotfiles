local config = require("tokyonight.config")
local colors = require("tokyonight.colors").setup(config)

local theme = {
  -- base
  Base = {
    fg = colors.fg,
    bg = config.transparent and colors.none or colors.bg_statusline,
  },
  Inactive = { fg = colors.fg_gutter, bg = colors.bg_statusline },

  -- vi mode
  Normal = { fg = colors.black, bg = colors.blue, attr = "bold" },
  Insert = { fg = colors.black, bg = colors.green, attr = "bold" },
  Visual = { fg = colors.black, bg = colors.megenta, attr = "bold" },
  Replace = { fg = colors.black, bg = colors.red, attr = "bold" },
  Command = { fg = colors.black, bg = colors.yellow, attr = "bold" },
  Terminal = { fg = colors.black, bg = colors.blue1, attr = "bold" },

  -- file
  FileIcon = { fg = colors.blue, bg = colors.fg_gutter },
  FileName = { fg = colors.fg, bg = colors.fg_gutter },
  FileModified = { fg = colors.orange, bg = colors.bg },
  FileReadonly = { fg = colors.red, bg = colors.bg },
  FileSize = { fg = colors.green, bg = colors.bg },
  FileFormat = { fg = colors.fg, bg = colors.bg },
  FileEncoding = { fg = colors.fg, bg = colors.bg },

  -- line/column info
  LineColumn = { fg = colors.fg, bg = colors.fg_gutter },
  LinePercent = { fg = colors.fg, bg = colors.fg_gutter },

  -- git
  BranchIcon = { fg = colors.purple, bg = colors.bg_statusline },
  BranchName = { fg = colors.fg, bg = colors.bg_statusline },

  -- diff
  DiffAdded = { fg = colors.git.add, bg = colors.bg_statusline },
  DiffModified = { fg = colors.git.change, bg = colors.bg_statusline },
  DiffRemoved = { fg = colors.git.delete, bg = colors.bg_statusline },

  -- LSP
  NearestSymbol = { fg = colors.purple, bg = colors.bg_statusline },

  -- diagnostic
  DiagnosticError = { fg = colors.black, bg = colors.error },
  DiagnosticWarning = { fg = colors.black, bg = colors.warning },
  DiagnosticInfo = { fg = colors.black, bg = colors.info },
  DiagnosticHint = { fg = colors.black, bg = colors.hint },
}

return theme
