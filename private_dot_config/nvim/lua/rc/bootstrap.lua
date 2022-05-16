--- ~/.config/nvim/rc/bootstrap.lua

------------------------------------------------------------------------------
-- Set global variables to change the default behavior {{{1

-- Enable (disable) lua (vim) based filetype detection {{{2
vim.g.do_filetype_lua = 1
vim.g.did_load_filetypes = 0
vim.g.did_indent_on = 1
vim.g.did_load_ftplugin = 1
-- }}}

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
  require "rc.gui"
end

require "rc.builtins"
require "rc.autocmds"
require "rc.options"
require "rc.mappings"

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
