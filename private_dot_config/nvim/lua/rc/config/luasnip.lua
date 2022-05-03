local M = {}

function M.config()
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
end

return M
