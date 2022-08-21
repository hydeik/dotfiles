local plugin = require("rc.core.pack").register_plugin
local conf = require("rc.modules.telescope.config")

-- Find, Filter, Preview, Pick. All lua, all the time.
plugin {
  "nvim-telescope/telescope.nvim",
  module = { "telescope" },
  cmd = { "Telescope" },
  requires = { "plenary.nvim", "nvim-web-devicons" },
  setup = conf.telescope.setup,
  config = conf.telescope.config,
}

-- [[ Telescope's extensions ]]

plugin {
  "nvim-telescope/telescope-cheat.nvim",
  after = "telescope.nvim",
  config = function()
    require("telescope").load_extension("cheat")
  end,
}

-- plugin {
--   "nvim-telescope/telescope-dap.nvim",
--   after = { "telescope.nvim", "nvim-dap" },
--   config = function()
--     require("telescope").load_extension("dap")
--   end,
-- }

plugin {
  "LinArcX/telescope-env.nvim",
  after = "telescope.nvim",
  config = function()
    require("telescope").load_extension("env")
  end,
}

plugin {
  "nvim-telescope/telescope-file-browser.nvim",
  after = "telescope.nvim",
  config = function()
    require("telescope").load_extension("file_browser")
  end,
}

plugin {
  "nvim-telescope/telescope-frecency.nvim",
  requires = { "sqlite.lua" },
  after = "telescope.nvim",
  config = function()
    require("telescope").load_extension("frecency")
  end,
}

plugin {
  "nvim-telescope/telescope-fzf-writer.nvim",
  after = "telescope.nvim",
  config = function()
    require("telescope").load_extension("fzf_writer")
  end,
}

plugin {
  "nvim-telescope/telescope-fzy-native.nvim",
  after = "telescope.nvim",
  config = function()
    require("telescope").load_extension("fzy_native")
  end,
}

plugin { "nvim-telescope/telescope-hop.nvim" }

plugin {
  "nvim-telescope/telescope-packer.nvim",
  after = "telescope.nvim",
  config = function()
    require("telescope").load_extension("packer")
  end,
}

plugin {
  "nvim-telescope/telescope-smart-history.nvim",
  requires = { "sqlite.lua" },
  after = "telescope.nvim",
  config = function()
    require("telescope").load_extension("smart_history")
  end,
}

plugin {
  "nvim-telescope/telescope-symbols.nvim",
  after = "telescope.nvim",
}

plugin {
  "nvim-telescope/telescope-ui-select.nvim",
  after = "telescope.nvim",
  config = function()
    require("telescope").load_extension("ui-select")
  end,
}
