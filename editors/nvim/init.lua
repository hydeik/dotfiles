-- ~/.config/nvim/init.lua -- NeoVim configuration
local ok, impatient = pcall(require, "impatient")
if ok then
  impatient.enable_profile()
end

if vim.fn.has "vim_starting" == 1 then
  require "core.startup"
end
require "core.keymap" -- introduce vim.keymap DSL

-- vim.cmd [[ silent! filetype off ]]
-- vim.cmd [[ syntax off ]]

require("plugins").ensure_plugins()
require("plugins").define_commands()

require "core.options"
require "core.mappings"
require("core.ftplugin").setup()
require("core.event").load_autocmds()

require "appearance"

if vim.fn.empty(vim.fn.argv()) == 0 then
  require("core.ftplugin").on_filetype()
end
