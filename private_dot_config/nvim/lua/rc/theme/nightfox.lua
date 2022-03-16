-- NightFox colorscheme

-- vim.cmd [[packadd nightfox.nvim]]
require("nightfox").setup {
  options = {
    transparent = vim.fn.exists "g:GuiLoaded" == 0 and vim.fn.has "gui" == 0 and vim.fn.exists "$SSH_CONNECTION" == 0,
    styles = {
      comments = "italic",
      keywords = "bold",
    },
    -- inverse = {
    --   visual = true,
    -- },
  },
  groups = {
    -- Vi mode
    StatuslineModeNormal = { fg = "pallet.blue", bg = "pallet.bg0", style = "bold" },
    StatuslineModeInsert = { fg = "pallet.green", bg = "pallet.bg0", style = "bold" },
    StatuslineModeVisual = { fg = "pallet.magenta", bg = "pallet.bg0", style = "bold" },
    StatuslineModeReplace = { fg = "pallet.red", bg = "pallet.bg0", style = "bold" },
    StatuslineModeCommand = { fg = "pallet.yellow", bg = "pallet.bg0", style = "bold" },
    StatuslineModeSelect = { fg = "pallet.cyan", bg = "pallet.bg0", style = "bold" },
    StatuslineModeOther = { fg = "pallet.white", bg = "pallet.bg0", style = "bold" },
    -- File info
    StatuslineFileIcon = { fg = "pallet.blue", bg = "pallet.bg0" },
    StatuslineFileName = { fg = "pallet.fg1", bg = "pallet.bg0", style = "bold" },
    StatuslineFileModified = { fg = "pallet.orange", bg = "pallet.bg0" },
    StatuslineFileReadonly = { fg = "pallet.red", bg = "pallet.bg0" },
    StatuslineFileSize = { fg = "pallet.cyan", bg = "pallet.bg0" },
    -- Git
    StatuslineGitBranch = { fg = "pallet.blue.dim", bg = "pallet.bg0" },
    -- Diff
    StatuslineDiffAdded = { fg = "git.add", bg = "pallet.bg0" },
    StatuslineDiffModified = { fg = "git.changed", bg = "pallet.bg0" },
    StatuslineDiffRemoved = { fg = "git.removed", bg = "pallet.bg0" },
    -- LSP
    StatuslineLspClient = { fg = "pallet.orange", bg = "pallet.bg0" },
    -- Diagnostics
    StatuslineDiagnosticError = { fg = "diag.error", bg = "pallet.bg0" },
    StatuslineDiagnosticWarning = { fg = "diag.warn", bg = "pallet.bg0" },
    StatuslineDiagnosticInfo = { fg = "diag.info", bg = "pallet.bg0" },
    StatuslineDiagnosticHint = { fg = "diag.hint", bg = "pallet.bg0" },
  },
}

vim.cmd "colorschem duskfox"
