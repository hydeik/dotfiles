vim.api.nvim_create_augroup("MyAutoCmd", { clear = true })

vim.api.nvim_create_autocmd("BufWritePost", {
  group = "MyAutoCmd",
  pattern = { "*.lua" },
  callback = function()
    require("rc.packer").auto_compile()
  end,
  desc = "Call packer.compile on saving config files written in lua.",
})

vim.api.nvim_create_autocmd("BufWritePre", {
  group = "MyAutoCmd",
  pattern = { "/tmp/*", "*.tmp", "*.bak", "COMMIT_EDITMSG", "MERGE_MSG" },
  command = "setlocal noundofile",
  desc = "Do not save undo histories for temporary/backup files.",
})

vim.api.nvim_create_autocmd("FocusGained", {
  group = "MyAutoCmd",
  command = "checktime",
  desc = "Check if any buffers were changed outside of (Neo)Vim.",
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = "MyAutoCmd",
  callback = function()
    vim.highlight.on_yank { timeout = 400 }
  end,
  desc = "Highlight yanked text.",
})

vim.api.nvim_create_autocmd("BufEnter", {
  group = "MyAutoCmd",
  callback = function()
    -- A hook after filetypeplugin events
    vim.opt_local.formatoptions = vim.opt_local.formatoptions
      - "r" -- Don't insert a comment leader after hitting <Enter>.
      - "o" -- Don't insert a comment leader after hitting 'o' or 'O'.
      - "a" -- Disable auto-format
      + "c" -- Auto-wrap comments using text width.
      + "q" -- Allow formatting of comments with "gq".
      + "n" -- Recognize numbered list when formatting text.
      + "l" -- Long lines are not broked in insert mode.
      + "m" -- Also break at a multibyte character above 255.
      + "M" -- Don't insert a space before or after a mutibyte character.
      + "j" -- Where it make sence, remove a comment leader when joining lines.

    if not vim.bo.modifiable then
      vim.wo.foldenable = false
      vim.wo.foldcolumn = "0"
      vim.wo.colorcolumn = ""
    end
  end,
  desc = "A hook after filetype-plugin events",
})
