local M = {
  "ggandor/leap.nvim",
  dependencies = {
    "tpope/vim-repeat",
    {
      "ggandor/flit.nvim",
      keys = { "f", "F", "t", "T" },
      config = {
        labeled_modes = "nv",
      },
    },
  },
  -- event = "VeryLazy",
  keys = {
    { "<Plug>(leap-", mode = { "n", "x", "o" } },
  },
}

M.init = function()
  vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-forward-to)")
  vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(leap-backward-to)")
  vim.keymap.set({ "x", "o" }, "x", "<Plug>(leap-forward-till)")
  vim.keymap.set({ "x", "o" }, "X", "<Plug>(leap-backward-till)")
  vim.keymap.set({ "n", "x", "o" }, "gs", "<Plug>(leap-cross-window)")
end
-- M.config = function()
--   require("leap").add_default_mappings()
-- end

return M
