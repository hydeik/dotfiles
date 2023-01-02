-- Enhanced increment/decrement plugin for Neovim.
local M = {
  "monaqa/dial.nvim",
  keys = {
    { "<Plug>(dial-", mode = { "n", "v" } },
  },
}

M.init = function()
  vim.keymap.set({ "n", "v" }, "<C-a>", "<Plug>(dial-increment)", { desc = "Dial increment" })
  vim.keymap.set({ "n", "v" }, "<C-x>", "<Plug>(dial-decrement)", { desc = "Dial decrement" })
  vim.keymap.set("v", "g<C-a>", "<Plug>(dial-increment-additional)", { desc = "Dial increment additional" })
  vim.keymap.set("v", "g<C-x>", "<Plug>(dial-decrement-additional)", { desc = "Dial decrement additional" })
end

M.config = function()
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
end

return M
