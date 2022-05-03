-- ~/.config/nvim/init.lua -- NeoVim configuration

-- Remove unnecessary dirs from `packpath`
vim.opt.packpath = vim.fn.stdpath "data" .. "/site"

-- Cache lua modules of plugins/configs
local ok, impatient = pcall(require, "impatient")
if ok then
  impatient.enable_profile()
else
  vim.notify(impatient)
end

-- Do all configs in rc/bootstrap.lua so that impatient.nvim can cache them.
require "rc.bootstrap"
