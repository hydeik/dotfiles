--- ~/.config/nvim/rc/bootstrap.lua

--- Ensure fundamental plugins are installed {{{1
local function ensure_plugin(user, name)
  if not string.find(vim.o.runtimepath, "/" .. name) then
    local repo_dir = string.format("%s/repos/%s/%s", vim.fn.stdpath "data", user, name)
    if vim.fn.isdirectory(repo_dir) == 0 then
      local repo_url = string.format("https://github.com/%s/%s", user, name)
      vim.fn.system { "git", "clone", "--depth", "1", repo_url, repo_dir }
    end
    vim.opt.runtimepath:prepend(repo_dir)
  end
end

-- impatient.nvim
ensure_plugin("lewis6991", "impatient.nvim")
local ok, impatient = pcall(require, "impatient")
if ok then
  if vim.env.IMPATIENT_PROFILE then
    impatient.enable_profile()
  end
else
  vim.notify(impatient)
end

-- dein.vim
ensure_plugin("Shougo", "dein.vim")
--- }}}1

--- Set packpath {{{1
vim.o.packpath = ""
--- }}}1

--- Set providers {{{1
-- python3 interpretor
vim.g.python3_host_prog = vim.fn.expand("~/.asdf/shims/python3")
-- Disable Nodejs / python2 / ruby / perl providers
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider = 0
--- }}}1

--- Lua based file type detection {{{1
-- Disable $VIMRUNTIME/filetype.vim and use $VIMRUNTIME/filetype.lua for file type detection
vim.g.do_filetype_lua = 1
vim.g.did_load_filetypes = 0
-- Also disable $VIMRUNTIME/{indent,ftplugin}.vim
vim.g.did_indent_on = 1
vim.g.did_load_ftplugin = 1
-- }}}1
--
--- Set mapleader, localmapleader, and other prefix keys for keymap {{{1
--[[ Leader/Localleader keys ]]
vim.g.mapleader = ";"
vim.g.maplocalleader = "\\"
-- release keymappings for plugins
vim.keymap.set("n", "<Space>", "<Nop>")
vim.keymap.set("x", "<Space>", "<Nop>")
vim.keymap.set("n", ";", "<Nop>")
vim.keymap.set("x", ";", "<Nop>")
vim.keymap.set("n", ",", "<Nop>")
vim.keymap.set("x", ",", "<Nop>")
vim.keymap.set("n", "m", "<Nop>")
vim.keymap.set("x", "m", "<Nop>")
vim.keymap.set("n", "s", "<Nop>")
vim.keymap.set("x", "s", "<Nop>")
--- }}}1

require("rc.user.events")
require("rc.user.builtin")
if vim.fn.has("gui_running") == 1 then
  require("rc.user.gui")
end
require("rc.dein")
require("rc.user.options")
require("rc.user.mappings")

-- vim: set foldmethod=marker
