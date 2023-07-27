return {
  -- Terminal Manager for Neovim
  "rebelot/terminal.nvim",
  keys = function(_, keys)
    local term_map = require "terminal.mappings"
    local mappings = {
      {
        "<Space>ts",
        term_map.operator_send,
        mode = { "n", "x" },
        expr = true,
        desc = "Send text captured by motion to a terminal",
      },
      { "<Space>to", term_map.toggle, desc = "Toggle terminal" },
      { "<Space>tO", term_map.toggle { open_cmd = "enew" }, desc = "Toggle terminal (new buffer)" },
      { "<Space>tr", term_map.run, desc = "Run a job in terminal" },
      { "<Space>tR", term_map.run { open_cmd = "enew" }, desc = "Run a job in terminal (new buffer)" },
      { "<Space>tk", term_map.kill, desc = "Kill terminal" },
      { "<Space>t]", term_map.cycle_next(), desc = "Cycle next terminal" },
      { "<Space>t[", term_map.cycle_prev(), desc = "Cycle previous terminal" },
      { "<Space>tl", term_map.move { open_cmd = "belowright vnew" }, desc = "Move terminal (belowright vnew)" },
      { "<Space>tL", term_map.move { open_cmd = "botright vnew" }, desc = "Move terminal (botright vnew)" },
      { "<Space>th", term_map.move { open_cmd = "belowright new" }, desc = "Move terminal (belowright new)" },
      { "<Space>tH", term_map.move { open_cmd = "botright new" }, desc = "Move terminal (botright new)" },
      { "<Space>tf", term_map.move { open_cmd = "botright new" }, desc = "Move terminal (floating window)" },
    }
    return vim.list_extend(keys, mappings)
  end,
  opts = {
    autoclose = true,
  },
  config = function(_, opts)
    require("terminal").setup(opts)
  end,
}
