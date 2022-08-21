-- [Nightfox](https://github.com/EdenEast/nightfox.nvim)
--
-- A highly customizable theme for vim and neovim with support for lsp, treesitter and a variety of plugins.
--
return {
  "EdenEast/nightfox.nvim",
  config = function()
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
        all = {
          -- Vi mode
          StatuslineModeNormal = { fg = "palette.blue", bg = "palette.bg0", style = "bold" },
          StatuslineModeInsert = { fg = "palette.green", bg = "palette.bg0", style = "bold" },
          StatuslineModeVisual = { fg = "palette.magenta", bg = "palette.bg0", style = "bold" },
          StatuslineModeReplace = { fg = "palette.red", bg = "palette.bg0", style = "bold" },
          StatuslineModeCommand = { fg = "palette.yellow", bg = "palette.bg0", style = "bold" },
          StatuslineModeSelect = { fg = "palette.cyan", bg = "palette.bg0", style = "bold" },
          StatuslineModeOther = { fg = "palette.white", bg = "palette.bg0", style = "bold" },
          -- File info
          StatuslineFileIcon = { fg = "palette.blue", bg = "palette.bg0" },
          StatuslineFileName = { fg = "palette.fg1", bg = "palette.bg0", style = "bold" },
          StatuslineFileModified = { fg = "palette.orange", bg = "palette.bg0" },
          StatuslineFileReadonly = { fg = "palette.red", bg = "palette.bg0" },
          StatuslineFileSize = { fg = "palette.cyan", bg = "palette.bg0" },
          -- Git
          StatuslineGitBranch = { fg = "palette.blue.dim", bg = "palette.bg0" },
          -- Diff
          StatuslineDiffAdded = { fg = "git.add", bg = "palette.bg0" },
          StatuslineDiffModified = { fg = "git.changed", bg = "palette.bg0" },
          StatuslineDiffRemoved = { fg = "git.removed", bg = "palette.bg0" },
          -- LSP
          StatuslineLspClient = { fg = "palette.orange", bg = "palette.bg0" },
          -- Diagnostics
          StatuslineDiagnosticError = { fg = "diag.error", bg = "palette.bg0" },
          StatuslineDiagnosticWarning = { fg = "diag.warn", bg = "palette.bg0" },
          StatuslineDiagnosticInfo = { fg = "diag.info", bg = "palette.bg0" },
          StatuslineDiagnosticHint = { fg = "diag.hint", bg = "palette.bg0" },
        },
      },
    }
    vim.cmd "colorschem duskfox"
  end
}
