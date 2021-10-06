-- ~/.config/nvim/init.lua -- NeoVim configuration
local ok, impatient = pcall(require, "impatient")
-- if ok then
--   impatient.enable_profile()
-- end

if vim.fn.has "vim_starting" == 1 then
  require "startup"
end

vim.g.did_load_filetypes = 1
require("plugins").ensure_plugins()
require("plugins").define_commands()

require "event"
require "ftplugin_"
require "options"
require "mappings"

require "appearance"
