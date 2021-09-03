-- ~/.config/nvim/init.lua -- NeoVim configuration
local cpath_extra = os.getenv "HOME" .. "/.luarocks/lib/lua/5.1/?.so"
if not string.find(package.cpath, cpath_extra, 1, true) then
  package.cpath = package.cpath .. ";" .. cpath_extra
end

local ok, impatient = pcall(require, "impatient")
if ok then
  impatient.enable_profile()
end

if vim.fn.has "vim_starting" == 1 then
  require "core.startup"
end

require("plugins").ensure_plugins()
vim.cmd [[command! PackerInstall           lua require('plugins').install()]]
vim.cmd [[command! PackerUpdate            lua require('plugins').update()]]
vim.cmd [[command! PackerSync              lua require('plugins').sync()]]
vim.cmd [[command! PackerClean             lua require('plugins').clean()]]
vim.cmd [[command! -nargs=* PackerCompile  lua require('plugins').compile(<q-args>)]]
vim.cmd [[command! PackerStatus            lua require('plugins').status()]]
vim.cmd [[command! PackerProfile           lua require('plugins').profile_output()]]
vim.cmd [[command! -nargs=+ -complete=customlist,v:lua.require'plugins'.loader_complete PackerLoad lua require('plugins').loader(<q-args>)]]

require "core.options"
require "core.mappings"
require("core.ftplugin").setup()
require("core.event").load_autocmds()

require "appearance"
