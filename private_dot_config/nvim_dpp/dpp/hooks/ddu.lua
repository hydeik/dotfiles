-- lua_add {{{

-- }}}

-- lua_source {{{
require("rc.plugins.ddu").custom.load_config(vim.fs.joinpath(vim.env.DPP_HOOKS_DIR, "ddu.ts"))
-- }}}

-- lua_post_update {{{
require("rc.plugins.ddu").set_static_import()
-- }}}
