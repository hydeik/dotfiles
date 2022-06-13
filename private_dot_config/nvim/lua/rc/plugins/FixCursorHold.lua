-- [FixCursorHold.nvim](https://github.com/antoinemadec/FixCursorHold.nvim)
--
-- Fix CursorHold Performance
-- TODO: remove it if https://github.com/neovim/neovim/issues/12587 is fixed.
--
return {
  "antoinemadec/FixCursorHold.nvim",
  config = function()
    vim.g.cursorhold_updatetime = 100
  end,
}
