local M = {}

function M.setup()
  local keymap = require "utils.keymap"
  keymap.nnoremap { "ss", "<cmd>lua require'hop'.hint_char2()<CR>" }
  keymap.xnoremap { "ss", "<cmd>lua require'hop'.hint_char2()<CR>" }
  keymap.onoremap { "ss", "<cmd>lua require'hop'.hint_char2()<CR>" }

  keymap.nnoremap { "sl", "<cmd>lua require'hop'.hint_lines()<CR>" }
  keymap.xnoremap { "sl", "<cmd>lua require'hop'.hint_lines()<CR>" }
  keymap.onoremap { "sl", "<cmd>lua require'hop'.hint_lines()<CR>" }

  keymap.nnoremap { "s/", "<cmd>lua require'hop'.hint_patterns()<CR>" }
  keymap.xnoremap { "s/", "<cmd>lua require'hop'.hint_patterns()<CR>" }
  keymap.onoremap { "s/", "<cmd>lua require'hop'.hint_patterns()<CR>" }
end

return M
