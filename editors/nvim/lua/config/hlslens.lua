local M = {}

function M.setup()
  local keymap = require "utils.keymap"
  keymap.nnoremap {
    "n",
    "<cmd>execute('normal! ' . v:count1 . 'n')<CR><cmd>lua require'hlslens'.start()<CR>",
    silent = true,
  }
  keymap.nnoremap {
    "N",
    "<cmd>execute('normal! ' . v:count1 . 'N')<CR><cmd>lua require'hlslens'.start()<CR>",
    silent = true,
  }
  keymap.nnoremap { "*", "*<cmd>lua require'hlslens'.start()<CR>", silent = true }
  keymap.nnoremap { "#", "#<cmd>lua require'hlslens'.start()<CR>", silent = true }
  keymap.nnoremap { "g*", "g*<cmd>lua require'hlslens'.start()<CR>", silent = true }
  keymap.nnoremap { "g#", "g#<cmd>lua require'hlslens'.start()<CR>", silent = true }
end

function M.config()
  require("hlslens").setup {
    auto_enable = true,
    calm_down = true,
  }
end

return M
