-- ~/.config/nvim/init.lua -- NeoVim configuration
local ok, impatient = pcall(require, "impatient")
if ok then
  impatient.enable_profile()
end

require "rc.bootstrap"
