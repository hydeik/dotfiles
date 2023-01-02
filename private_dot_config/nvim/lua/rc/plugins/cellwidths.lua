local M = {
  "delphinus/cellwidths.nvim",
  event = { "BufEnter" },
}

M.build = function()
  vim.cmd.CellWidthsRemove()
end

M.config = function()
  require("cellwidths").setup {
    name = "user/custom",
    ---@param cw cellwidths
    fallback = function(cw)
      cw.load "default"
      --cw.add ...
    end,
  }
end

return M
