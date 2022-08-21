local M = {}
local palette_colors = {

  -- Bg Shades
  sumiInk0  = "#16161D",
  sumiInk1b = "#181820",
  sumiInk1  = "#1F1F28",
  sumiInk2  = "#2A2A37",
  sumiInk3  = "#363646",
  sumiInk4  = "#54546D",

  -- Popup and Floats
  waveBlue1 = "#223249",
  waveBlue2 = "#2D4F67",

  -- Diff and Git
  winterGreen  = "#2B3328",
  winterYellow = "#49443C",
  winterRed    = "#43242B",
  winterBlue   = "#252535",
  autumnGreen  = "#76946A",
  autumnRed    = "#C34043",
  autumnYellow = "#DCA561",

  -- Diag
  samuraiRed  = "#E82424",
  roninYellow = "#FF9E3B",
  waveAqua1   = "#6A9589",
  dragonBlue  = "#658594",

  -- Fg and Comments
  oldWhite      = "#C8C093",
  fujiWhite     = "#DCD7BA",
  fujiGray      = "#727169",
  springViolet1 = "#938AA9",

  oniViolet     = "#957FB8",
  crystalBlue   = "#7E9CD8",
  springViolet2 = "#9CABCA",
  springBlue    = "#7FB4CA",
  lightBlue     = "#A3D4D5", -- unused yet
  waveAqua2     = "#7AA89F", -- improve lightness: desaturated greenish Aqua
  -- waveAqua2  = "#68AD99",
  -- waveAqua4  = "#7AA880",
  -- waveAqua5  = "#6CAF95",
  -- waveAqua3  = "#68AD99",

  springGreen = "#98BB6C",
  boatYellow1 = "#938056",
  boatYellow2 = "#C0A36E",
  carpYellow  = "#E6C384",

  sakuraPink   = "#D27E99",
  waveRed      = "#E46876",
  peachRed     = "#FF5D62",
  surimiOrange = "#FFA066",
  katanaGray   = "#717C7C",
}

M.config = function()
  local colors = require("kanagawa.colors").setup()

  local overrides = {
    -- Window bar
    WinBar = { link = "StatusLine" },
    WinBarNC = { link = "StatusLineNC" },
    WinBarFileName = { fg = colors.fg, bg = colors.bg_status, bold = true },
    WinBarFileIcon = { fg = colors.springBlue, bg = colors.bg_status },
    WinBarFileModified = { fg = colors.surimiOrange, bg = colors.bg_status },
    WinBarContext = { fg = colors.fg_dark, bg = colors.bg_status },
  }

  require("kanagawa").setup {
    dimInactive = true,
    globalStatus = true,
    transparent = true,
    overrides = overrides,
    theme = "default",
  }

  vim.cmd.colorscheme("kanagawa")
end

return M
