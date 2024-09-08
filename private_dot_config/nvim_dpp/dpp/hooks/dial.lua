--- [dial.nvim](https://github.com/monaqa/dial.nvim)
-- Enhanced increment/decrement plugin for Neovim.

-- lua_add {{{
vim.keymap.set("n", "<C-a>", function()
  require("dial.map").manipulate("increment", "normal")
end, { desc = "Dial increment" })

vim.keymap.set("n", "<C-x>", function()
  require("dial.map").manipulate("decrement", "normal")
end, { desc = "Dial decrement" })

vim.keymap.set("n", "g<C-a>", function()
  require("dial.map").manipulate("increment", "gnormal")
end, { desc = "Dial increment" })

vim.keymap.set("n", "g<C-x>", function()
  require("dial.map").manipulate("decrement", "gnormal")
end, { desc = "Dial decrement" })

vim.keymap.set("v", "<C-a>", function()
  require("dial.map").manipulate("increment", "visual")
end, { desc = "Dial increment" })

vim.keymap.set("v", "<C-x>", function()
  require("dial.map").manipulate("decrement", "visual")
end, { desc = "Dial decrement" })

vim.keymap.set("v", "g<C-a>", function()
  require("dial.map").manipulate("increment", "gvisual")
end, { desc = "Dial increment" })

vim.keymap.set("v", "g<C-x>", function()
  require("dial.map").manipulate("decrement", "gvisual")
end, { desc = "Dial decrement" })
-- }}}

-- lua_source {{{
local augend = require "dial.augend"
require("dial.config").augends:register_group {
  default = {
    augend.integer.alias.decimal,
    augend.integer.alias.hex,
    augend.date.alias["%Y-%m-%d"],
    augend.constant.alias.bool,
    augend.semver.alias.semver,
  },
}
-- }}}
