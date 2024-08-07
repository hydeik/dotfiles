-- lua_add {{{

-- }}}

-- lua_source {{{
vim.fn["ddu#custom#load_config"](vim.fs.joinpath(vim.env.VIM_CONFIG_DIR, "dpp", "ddu.ts"))
-- }}}

-- lua_post_update {{{
vim.fn["ddu#set_static_import"]()
-- }}}
