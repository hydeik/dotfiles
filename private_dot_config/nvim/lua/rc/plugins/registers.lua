-- Neovim plugin to preview the contents of the registers
return {
  "tversteeg/registers.nvim",
  keys = {
    { '"', mode = { "n", "v" } },
    { "<C-R>", mode = "i" },
  },
  cmd = "Registers",
  opts = {
    window = {
      border = "rounded",
    },
  },
}
