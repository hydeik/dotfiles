local au = require "rc.core.autocmd"
au.group("MyAutoCmd", {
  { "BufWritePost", "*.lua", "lua require'rc.plugins'.auto_compile()" },
  { "BufWritePre", "/tmp/*", "setlocal noundofile" },
  { "BufWritePre", "*.tmp", "setlocal noundofile" },
  { "BufWritePre", "*.bak", "setlocal noundofile" },
  { "BufWritePre", "COMMIT_EDITMSG", "setlocal noundofile" },
  { "BufWritePre", "MERGE_MSG", "setlocal noundofile" },
  { "FocusGained", "*", "checktime" },
  {
    "TextYankPost",
    "*",
    function()
      vim.highlight.on_yank { timeout = 400 }
    end,
  },
  {
    "BufEnter",
    "*",
    function()
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
  },
}, true)
