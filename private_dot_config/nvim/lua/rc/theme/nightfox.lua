-- NightFox colorscheme

-- vim.cmd [[packadd nightfox.nvim]]
local nightfox = require "nightfox"
local opts = {
  fox = "duskfox",
  styles = {
    comments = "italic",
    keywords = "bold",
  },
  inverse = {
    visual = true,
  },
  hlgroups = {
    -- Vi mode
    StatuslineModeNormal = { fg = "${blue}", bg = "${bg_statusline}", style = "bold" },
    StatuslineModeInsert = { fg = "${green}", bg = "${bg_statusline}", style = "bold" },
    StatuslineModeVisual = { fg = "${magenta}", bg = "${bg_statusline}", style = "bold" },
    StatuslineModeReplace = { fg = "${red}", bg = "${bg_statusline}", style = "bold" },
    StatuslineModeCommand = { fg = "${yellow}", bg = "${bg_statusline}", style = "bold" },
    StatuslineModeSelect = { fg = "${cyan}", bg = "${bg_statusline}", style = "bold" },
    StatuslineModeOther = { fg = "${white}", bg = "${bg_statusline}", style = "bold" },
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
