--- [oil.nvim](https://github.com/stevearc/oil.nvim)
-- Neovim file explorer: edit your filesystem like a buffer

-- lua_add {{{
vim.keymap.set("n", "-", function()
  require("oil").open()
end, { desc = "[Oil] Open parent directory" })
vim.keymap.set("n", "<Space>-", function()
  require("oil").toggle_float()
end, { desc = "[Oil] Open parent directory (floating, toggle)" })
-- }}}

-- lua_source {{{
local trash_cmd = "rip"
local has_trash = vim.fn.executable(trash_cmd) == 1
require("oil").setup {
  delete_to_trash = has_trash,
  trash_command = trash_cmd,
  view_options = {
    show_hidden = true,
  },
}
-- }}}
