local M = {}

function M.config()
  require("gitsigns").setup {
    signs = {
      add = { hl = "DiffAdd", text = "│", numhl = "GitSignsAddNr" },
      change = { hl = "DiffChange", text = "│", numhl = "GitSignsChangeNr" },
      delete = { hl = "DiffDelete", text = "_", numhl = "GitSignsDeleteNr" },
      topdelete = { hl = "DiffDelete", text = "‾", numhl = "GitSignsDeleteNr" },
      changedelete = { hl = "DiffChange", text = "~", numhl = "GitSignsChangeNr" },
    },
    keymaps = {
      noremap = true,
      buffer = true,

      ["n ]c"] = {
        expr = true,
        "&diff ? ']c' : '<Cmd>lua require\"gitsigns\".next_hunk()<CR>'",
      },
      ["n [c"] = {
        expr = true,
        "&diff ? '[c' : '<Cmd>lua require\"gitsigns\".prev_hunk()<CR>'",
      },

      ["n <leader>hs"] = '<Cmd>lua require"gitsigns".stage_hunk()<CR>',
      ["n <leader>hu"] = '<Cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
      ["n <leader>hr"] = '<Cmd>lua require"gitsigns".reset_hunk()<CR>',
      ["n <leader>hp"] = '<Cmd>lua require"gitsigns".preview_hunk()<CR>',
      ["n <leader>hb"] = '<Cmd>lua require"gitsigns".blame_line()<CR>',

      -- Text objects
      ["o ih"] = ':<C-U>lua require"gitsigns".text_object()<CR>',
      ["x ih"] = ':<C-U>lua require"gitsigns".text_object()<CR>',
    },
    sign_priority = 6,
    watch_gitdir = { enabled = true, interval = 1000 },
    status_formatter = nil, -- use default
  }
end

return M
