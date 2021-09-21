-- ~/.config/nvim/init.lua -- NeoVim configuration
local ok, impatient = pcall(require, "impatient")
if ok then
  impatient.enable_profile()
end

if vim.fn.has "vim_starting" == 1 then
  require "startup"
end
require "utils.keymap" -- introduce vim.keymap DSL

-- vim.cmd [[ silent! filetype off ]]
-- vim.cmd [[ syntax off ]]

require("plugins").ensure_plugins()
require("plugins").define_commands()

require "event"
require("ftplugin").setup()
require "options"
require "mappings"
-- require("core.ftplugin").setup()

require "appearance"
