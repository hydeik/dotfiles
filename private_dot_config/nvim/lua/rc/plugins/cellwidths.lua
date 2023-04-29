return {
  "delphinus/cellwidths.nvim",
  event = { "BufEnter" },
  build = function()
    vim.cmd.CellWidthsRemove()
  end,
  opts = {
    name = "user/custom",
    ---@param cw cellwidths
    fallback = function(cw)
      cw.load "default"
      --cw.add ...
      cw.add { 0xf0000, 0x10ffff, 2 }
      -- cw.add(0xEA87, 2)
      -- cw.add(0xEA6C, 2)
      -- cw.add(0xEA6B, 2)
      -- cw.add(0xEA74, 2)
      -- cw.add(0xEAB2, 2)
    end,
  },
}
