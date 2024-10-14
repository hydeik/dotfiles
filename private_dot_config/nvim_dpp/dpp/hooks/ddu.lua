-- lua_add {{{
local ddu = require "rc.plugins.ddu"

vim.keymap.set("n", "<Space>fb", function()
  ddu.start {
    name = "buffer",
    sources = { "buffer" },
  }
end, { desc = "Buffers" })

vim.keymap.set("n", "<Space>fd", function()
  ddu.start { name = "file_fd" }
end, { desc = "Files (fd)" })

vim.keymap.set("n", "<Space>ff", function()
  ddu.start {
    name = "filer-" .. vim.api.nvim_get_current_win(),
    sources = { "file" },
    ui = "filer",
    resume = true,
    sync = true,
  }
end, { desc = "File explore" })

-- Search
vim.keymap.set("n", "/", function()
  ddu.start {
    name = "search",
    sources = { "line" },
    resume = false,
    input = vim.fn.escape(vim.fn.input "Pattern: ", " "),
  }
end, { desc = "Search Pattern" })

vim.keymap.set("n", "*", function()
  ddu.start {
    name = "search",
    sources = { "line" },
    resume = false,
    input = vim.fn.expand "<cword>",
  }
end, { desc = "Search <cword>" })

vim.keymap.set("n", "n", function()
  ddu.start {
    name = "search",
    resume = true,
  }
end, { desc = "Search resume" })

vim.keymap.set("n", "<Space>sh", function()
  ddu.start {
    name = "help",
    sources = { "help" },
  }
end, { desc = "Help Pages" })

-- }}}

-- lua_source {{{
-- require("rc.plugins.ddu").custom.load_config(vim.fs.joinpath(vim.env.DPP_CONFIG_DIR, "ddu.ts"))
local ddu_ = require "rc.plugins.ddu"
ddu_.custom.load_config(vim.fs.joinpath(vim.env.DPP_HOOKS_DIR, "ddu", "main.ts"))
ddu_.custom.load_config(vim.fs.joinpath(vim.env.DPP_HOOKS_DIR, "ddu", "ff.ts"))
ddu_.custom.load_config(vim.fs.joinpath(vim.env.DPP_HOOKS_DIR, "ddu", "filer.ts"))
-- }}}

-- lua_post_update {{{
require("rc.plugins.ddu").set_static_import()
-- }}}
