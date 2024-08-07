-- Smart and powerful comment plugin for neovim. Supports treesitter,
-- dot repeat, left-right/up-down motions, hooks, and more

-- lua_add {{{

-- Basic mappings
vim.keymap.set("n", "gcc", function()
  return vim.api.nvim_get_vvar "count" == 0 and "<Plug>(comment_toggle_linewise_current)"
    or "<Plug>(comment_toggle_linewise_count)"
end, { expr = true, desc = "Comment toggle current line" })

vim.keymap.set("n", "gbc", function()
  return vim.api.nvim_get_vvar "count" == 0 and "<Plug>(comment_toggle_blockwise_current)"
    or "<Plug>(comment_toggle_blockwise_count)"
end, { expr = true, desc = "Comment toggle current block" })

vim.keymap.set("n", "gc", "<Plug>(comment_toggle_linewise)", { desc = "Comment toggle linewise" })
vim.keymap.set("n", "gb", "<Plug>(comment_toggle_linewise)", { desc = "Comment toggle blockwise" })
vim.keymap.set("x", "gc", "<Plug>(comment_toggle_linewise_visual)", { desc = "Comment toggle linewise (visual)" })
vim.keymap.set("x", "gb", "<Plug>(comment_toggle_blockwise_visual)", { desc = "Comment toggle blockwise (visual)" })

-- Extra mappings
vim.keymap.set("n", "gco", function()
  require("Comment.api").insert.linewise.below()
end, { desc = "Comment insert below" })
vim.keymap.set("n", "gcO", function()
  require("Comment.api").insert.linewise.above()
end, { desc = "Comment insert above" })
vim.keymap.set("n", "gcA", function()
  require("Comment.api").locked("insert.linewise.eol")()
end, { desc = "Comment insert end of line" })

-- }}}

-- lua_source {{{
require("Comment").setup {
  -- set mappings manually
  mappings = {
    basic = false,
    extra = false,
  },
  ---Pre-hook, called before commenting the line
  ---@type function
  pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
}
-- }}}
