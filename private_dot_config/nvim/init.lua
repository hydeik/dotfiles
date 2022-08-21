-------------------------------------------------------------------------------
-- ~/.config/nvim/init.lua
-- Init file for Neovim
-------------------------------------------------------------------------------

-- Bootstrap:
--   Install the plugin manager, and impatient.nvim
local pack = require("rc.core.pack")
pack.bootstrap()

-- Change Neovim's default behavior:
--   1. Use lua based filetype detection
--   2. Disable unused providers for remote plugins
--   3. Disable some built-in Neovim plugins
--   4. Set global options
require("rc.core.settings")

-- Define augroup and autocmds
require("rc.core.autocmds")

-- Define key mappings for Neovim built-in functionality
require("rc.core.mappings")

-- Load and configure plugins
pack.load_cache()

-- Appearance (theme, statusline, winbar)
require("rc.core.ui")
