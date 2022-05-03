--- ~/.config/nvim/rc/bootstrap.lua

------------------------------------------------------------------------------
-- Set global variables to change the default behavior {{{1

-- Enable (disable) lua (vim) based filetype detection {{{2
vim.g.do_filetype_lua = 1
vim.g.did_load_filetypes = 0
vim.g.did_indent_on = 1
vim.g.did_load_ftplugin = 1
-- }}}

-- Disable some builtin plugins. {{{2
vim.g.loaded_2html_plugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_man = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.netrw_nogx = 1
vim.g.loaded_netrwFileHandlers = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
-- }}}2

-- Providers (set python3 interpreter, disable nodejs, perl, ruby) {{{2
vim.g.python3_host_prog = vim.env.HOME .. "/.asdf/shims/python3"
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
-- }}}
-- }}}

------------------------------------------------------------------------------
-- Run {{{1
if vim.fn.has "gui_running" == 1 then
  -- Configure for Neovim GUI.
  require "rc.user.gui"
end

require "rc.user.events"
require "rc.user.options"
require "rc.user.mappings"

local plugins = require "rc.packer"
plugins.bootstrap(function(installed)
  if installed then
    -- Automatically set up plugin configuration after cloning packer.nvim.
    vim.api.nvim_create_autocmd("User", {
      desc = "Load my config after packer.nvim is setup.",
      pattern = "PackerComplete",
      once = true,
      callback = function()
        require "packer_compiled"
      end,
    })
    plugins.sync()
  else
    -- packer.nvim is not required on startup, so just require main configuration file
    require "packer_compiled"
  end
end)

require("rc.statusline").setup()

-- }}}
