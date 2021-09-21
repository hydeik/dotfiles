-- ~/.config/nvim/lua/core/event.lua
local au = require "utils.autocmd"
au.group("MyAutoCmd", {
  { "BufWritePost", "*.lua", "lua require'plugins'.auto_compile()" },
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
      vim.highlight.on_yank { higroup = "IncSearch", timeout = 400 }
    end,
  },
}, true)
