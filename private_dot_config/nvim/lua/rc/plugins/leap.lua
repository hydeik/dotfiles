local M = {
  "ggandor/leap.nvim",
  dependencies = {
    "tpope/vim-repeat",
    {
      "ggandor/flit.nvim",
      keys = function()
        ---@type LazyKeys[]
        local ret = {}
        for _, key in ipairs { "f", "F", "t", "T" } do
          ret[#ret + 1] = { key, mode = { "n", "x", "o" }, desc = key }
        end
        return ret
      end,
      config = {
        labeled_modes = "nx",
      },
    },
  },
  -- event = "VeryLazy",
  keys = {
    { "ss", "<Plug>(leap-forward-to)", mode = { "n", "x", "o" }, desc = "Leap forward to" },
    { "sS", "<Plug>(leap-backward-to)", mode = { "n", "x", "o" }, desc = "Leap backward to" },
    { "SS", "<Plug>(leap-cross-window)", mode = { "n", "x", "o" }, desc = "Leap cross window" },
  },
  config = true,
}

return M
