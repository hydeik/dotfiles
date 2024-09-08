--- [nvim-insx](https://github.com/hrsh7th/nvim-insx)
-- Flexible key mapping manager.

-- lua_source {{{
vim.keymap.set({ "i", "c" }, "<C-h>", "<BS>", { remap = true })

local insx = require "insx"

require("insx.preset.standard").setup {
  cmdline = { enabled = true },
  fast_break = { enabled = true, arguments = true, html_attrs = true },
  fast_wrap = { enabled = true },
  spacing = { enabled = true },
}

local endwise = require "insx.recipe.endwise"
insx.add("<CR>", endwise(endwise.builtin))
-- }}}
