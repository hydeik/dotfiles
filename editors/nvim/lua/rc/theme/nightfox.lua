-- NightFox colorscheme

-- vim.cmd [[packadd nightfox.nvim]]
local nightfox = require "nightfox"
local opts = {
  fox = "palefox",
  styles = {
    comments = "italic",
    keywords = "bold",
  },
  inverse = {
    visual = true,
  },
  hlgroups = {
    -- Vi mode
    StatuslineModeNormal = { fg = "${black}", bg = "${blue}", style = "bold" },
    StatuslineModeInsert = { fg = "${black}", bg = "${green}", style = "bold" },
    StatuslineModeVisual = { fg = "${black}", bg = "${magenta}", style = "bold" },
    StatuslineModeReplace = { fg = "${black}", bg = "${red}", style = "bold" },
    StatuslineModeCommand = { fg = "${black}", bg = "${yellow}", style = "bold" },
    StatuslineModeSelect = { fg = "${black}", bg = "${cyan}", style = "bold" },
    StatuslineModeOther = { fg = "${black}", bg = "${white}", style = "bold" },
    -- File info
    StatuslineFileIcon = { fg = "${blue}", bg = "${bg_statusline}" },
    StatuslineFileName = { fg = "${fg}", bg = "${bg_statusline}", style = "bold" },
    StatuslineFileModified = { fg = "${orange}", bg = "${bg_statusline}" },
    StatuslineFileReadonly = { fg = "${red}", bg = "${bg_statusline}" },
    StatuslineFileSize = { fg = "${cyan}", bg = "${bg_statusline}" },
    -- Git
    StatuslineGitBranch = { fg = "${blue_dm}", bg = "${bg_statusline}" },
    -- Diff
    StatuslineDiffAdded = { fg = "${git.add}", bg = "${bg_statusline}" },
    StatuslineDiffModified = { fg = "${git.change}", bg = "${bg_statusline}" },
    StatuslineDiffRemoved = { fg = "${git.delete}", bg = "${bg_statusline}" },
    -- LSP
    StatuslineLspClient = { fg = "${orange}", bg = "${bg_statusline}" },
    -- Diagnostics
    StatuslineDiagnosticError = { fg = "${error}", bg = "${bg_statusline}" },
    StatuslineDiagnosticWarning = { fg = "${warning}", bg = "${bg_statusline}" },
    StatuslineDiagnosticInfo = { fg = "${info}", bg = "${bg_statusline}" },
    StatuslineDiagnosticHint = { fg = "${hint}", bg = "${bg_statusline}" },
  },
}
if vim.fn.exists "g:GuiLoaded" == 0 and vim.fn.has "gui" == 0 and vim.fn.exists "$SSH_CONNECTION" == 0 then
  opts.transparent = true
end

nightfox.setup(opts) -- configure
nightfox.load() -- set colorscheme

-- local colors = {
--   meta = { name = "palefox", light = false },

--   none = "NONE",
--   bg = "#3d3f52",

--   fg = "#f8f8f2",
--   fg_gutter = "#5a5475",

--   black = "#3b3a32",
--   red = "#f1756f",
--   green = "#6de874",
--   yellow = "#f0e656",
--   blue = "#a381ff",
--   magenta = "#ff87b1",
--   cyan = "#7ef5b8",
--   white = "#c7b7c7",
--   orange = "#f5b87f",
--   pink = "#ffb8d1",

--   -- +15 brightness, -15 saturation
--   -- black_br = "#685868",
--   black_br = "#9c97ac",
--   red_br = "#ff9f9a",
--   green_br = "#7bfa81",
--   yellow_br = "#ffea00",
--   blue_br = "#c5a3ff",
--   magenta_br = "#ffb8d1",
--   cyan_br = "#c2ffdf",
--   white_br = "#ffefff",
--   orange_br = "#efc39a",
--   pink_br = "#fbc7d9",

--   -- -15 brightness, -15 saturation
--   black_dm = "#31302a",
--   red_dm = "#df534c",
--   green_dm = "#4dd554",
--   yellow_dm = "#b4990f",
--   blue_dm = "#7e55f0",
--   magenta_dm = "#f1588e",
--   cyan_dm = "#59e49c",
--   white_dm = "#ac99ac",
--   orange_dm = "#e49c59",
--   pink_dm = "#f57fa9",

--   comment = "#6f6b80",

--   git = {
--     add = "#70a288",
--     change = "#a58155",
--     delete = "#904a6a",
--     conflict = "#c07a6d",
--   },

--   gitSigns = {
--     add = "#164846",
--     change = "#394b70",
--     delete = "#823c41",
--   },
-- }
