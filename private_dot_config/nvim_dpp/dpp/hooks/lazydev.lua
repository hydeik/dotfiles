-- lua_source {{{

require("lazydev").setup {
  library = {
    { path = "luvit-meta/library", words = { "vim%.uv" } },
  },
  integrations = {
    -- Fixes lspconfig's workspace management for LuaLS
    -- Only create a new workspace if the buffer is not part
    -- of an existing workspace or one of its libraries
    lspconfig = true,
    -- add the cmp source for completion of:
    -- `require "modname"`
    -- `---@module "modname"`
    cmp = true,
    -- same, but for Coq
    coq = false,
  },
}

-- }}}
