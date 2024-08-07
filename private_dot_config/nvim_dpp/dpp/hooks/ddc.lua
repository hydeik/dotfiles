--- [ddc.vim](https://github.com/Shougo/ddc.vim)

-- lua_add {{{
-- }}}

-- lua_source {{{
vim.fn["ddc#custom#load_config"]("$VIM_CONFIG_DIR/dpp/ddc.ts")
-- }}}

-- lua_post_update {{{
vim.fn["ddc#set_static_import_path"]()
-- }}}
