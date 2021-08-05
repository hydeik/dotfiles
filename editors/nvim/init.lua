-- ~/.config/nvim/init.lua -- NeoVim configuration
if vim.fn.has("vim_starting") == 1 then
	require("core.startup")
end

require("plugins").ensure_plugins()
vim.cmd([[command! PackerCompile lua require('plugins').compile()]])
vim.cmd([[command! PackerInstall lua require('plugins').install()]])
vim.cmd([[command! PackerUpdate  lua require('plugins').update()]])
vim.cmd([[command! PackerSync    lua require('plugins').sync()]])
vim.cmd([[command! PackerClean   lua require('plugins').clean()]])

require("core.options")
require("core.mappings")
require("core.ftplugin").setup()
require("core.event").load_autocmds()

require("appearance")
