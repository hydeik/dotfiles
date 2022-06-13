-- [LuaSnip](https://github.com/L3MON4D3/LuaSnip)
--
-- Snippet Engine for Neovim written in Lua.
--
return {
  "L3MON4D3/LuaSnip",
  module = { "luasnip" },
  event = { "InsertEnter" },
  requires = {
    { "rafamadriz/friendly-snippets" },
  },
  config = function()
    require("luasnip").config.set_config {
      history = true,
      updateevents = "TextChanged,TextChangedI",
    }
    -- register snippets directories
    local path = require "rc.core.path"
    require("luasnip.loaders.from_vscode").load {
      paths = {
        -- REMARK: package.json files are required in the following directories
        -- path.join(path.config_home, "snippets"),
        path.join(path.pack_root, "packer", "start", "friendly-snippets"),
      },
    }
  end,
}
