local group_id = vim.api.nvim_create_augroup("MyAutoCmd", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
  group = group_id,
  pattern = { "/tmp/*", "*.tmp", "*.bak", "COMMIT_EDITMSG", "MERGE_MSG" },
  command = "setlocal noundofile",
  desc = "Do not save undo histories for temporary/backup files.",
})

vim.api.nvim_create_autocmd("FocusGained", {
  group = group_id,
  command = "checktime",
  desc = "Check if any buffers were changed outside of (Neo)Vim.",
})

vim.api.nvim_create_autocmd("VimResized", {
  group = group_id,
  command = "tabdo wincmd =",
  desc = "Resize splits if window got resized",
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = group_id,
  callback = function()
    vim.highlight.on_yank { timeout = 500 }
  end,
  desc = "Highlight yanked text.",
})

vim.api.nvim_create_autocmd("BufReadPost", {
  group = group_id,
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
  desc = "Go to last loc when opening a buffer",
})

vim.api.nvim_create_autocmd("BufEnter", {
  group = group_id,
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
