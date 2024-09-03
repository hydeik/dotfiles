-- lua_add {{{

vim.keymap.set("n", "<Space>fb", function()
  vim.fn["ddu#start"] {
    name = "buffer",
    sources = { "buffer" },
  }
end, { desc = "Buffers" })

vim.keymap.set("n", "<Space>ff", function()
  vim.fn["ddu#start"] { name = "buffer" }
end, { desc = "Buffers" })

-- Search
vim.keymap.set("n", "/", function()
  vim.fn["ddu#start"] {
    name = "search",
    sources = { "line" },
    resume = false,
    input = vim.fn.escape(vim.fn["cmdline#input"] "Pattern: ", " "),
  }
end, { desc = "Search Pattern" })

vim.keymap.set("n", "*", function()
  vim.fn["ddu#start"] {
    name = "search",
    sources = { "line" },
    resume = false,
    input = vim.fn.expand "<cword>",
  }
end, { desc = "Search <cword>" })

vim.keymap.set("n", "n", function()
  vim.fn["ddu#start"] {
    name = "search",
    resume = true,
  }
end, { desc = "Search resume" })

vim.keymap.set("n", "<Space>sh", function()
  vim.fn["ddu#start"] {
    name = "help",
    sources = { "help" },
  }
end, { desc = "Help Pages" })

-- }}}

-- lua_source {{{
vim.fn["ddu#custom#load_config"](vim.fs.joinpath(vim.env.DPP_CONFIG_DIR, "ddu.ts"))
-- }}}

-- lua_post_update {{{
vim.fn["ddu#set_static_import"]()
-- }}}
