-- Automatically expand width of the current window. Maximizes and restore it. And all this with nice animations!
local enable_animation = false
return {
  "anuvyklack/windows.nvim",
  dependencies = {
    { "anuvyklack/middleclass" },
    { "anuvyklack/animation.nvim", cond = enable_animation },
  },
  event = { "WinNew" },
  cmd = {
    "WindowMaximize",
    "WindowMaximizeVertically",
    "WindowMaximizeHorizontally",
    "WindowEqualize",
    "WindowEnableAutowidth",
    "WindowDisableAutowidth",
    "WindowToggleAutowidth",
  },
  config = function()
    -- if you enable animations, is recommended to set winwidth, winminwidth options to some
    -- reasonable and equal values (between 5 and 20 will be OK), and disable equalalways option.
    -- NOTE: those options are set in `rc.core.options`
    -- vim.o.winminwidth = 10
    -- vim.o.winminwidth = 10
    -- vim.o.equalalways = false
    require("windows").setup {
      animation = {
        enable = enable_animation,
        duration = 150,
      },
    }
  end,
}
