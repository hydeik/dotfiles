return {
  -- copilot language server
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local sk = require("rc.utils.lazy").get_plugin_opts "sidekick.nvim"
      if vim.tbl_get(sk, "nes", "enabled") ~= false then
        opts.servers = opts.servers or {}
        opts.servers.copilot = opts.servers.copilot or {}
      end
    end,
  },

  -- sidekick
  {
    "folke/sidekick.nvim",
    opts = function()
      require("rc.utils.cmp").ai_nes = function()
        local nes = require "sidekick.nes"
        if nes.have() and (nes.jump() or nes.apply()) then
          return true
        end
      end

      Snacks.toggle({
        name = "Sidekick NES",
        get = function()
          return require("sidekick.nes").enabled
        end,
        set = function(state)
          return require("sidekick.nes").enable(state)
        end,
      }):map "<Space>uN"
    end,
    keys = {
      {
        "<Tab>",
        function()
          require("rc.utils.cmp").map({ "ai_nes" }, "<Tab>")
        end,
        mode = { "n" },
        expr = true,
      },
      { "<Space>a", "", desc = "+ai", mode = { "n", "v" } },
      {
        "<Space>aa",
        function()
          require("sidekick.cli").toggle()
        end,
        desc = "Sidekick Toggle CLI",
      },
      {
        "<Space>as",
        function()
          require("sidekick.cli").select()
        end,
        -- Or to select only installed tools:
        -- require("sidekick.cli").select({ filter = { installed = true } })
        desc = "Select CLI",
      },
      {
        "<Space>ad",
        function()
          require("sidekick.cli").close()
        end,
        desc = "Detach a CLI Session",
      },
      {
        "<Space>at",
        function()
          require("sidekick.cli").send { msg = "{this}" }
        end,
        mode = { "x", "n" },
        desc = "Send This",
      },
      {
        "<Space>af",
        function()
          require("sidekick.cli").send { msg = "{file}" }
        end,
        desc = "Send File",
      },
      {
        "<Space>av",
        function()
          require("sidekick.cli").send { msg = "{selection}" }
        end,
        mode = { "x" },
        desc = "Send Visual Selection",
      },
      {
        "<Space>ap",
        function()
          require("sidekick.cli").prompt()
        end,
        mode = { "n", "x" },
        desc = "Sidekick Select Prompt",
      },
    },
  },
  -- snacks picker action
  {
    "folke/snacks.nvim",
    optional = true,
    opts = {
      picker = {
        actions = {
          sidekick_send = function(...)
            return require("sidekick.cli.picker.snacks").send(...)
          end,
        },
        win = {
          input = {
            keys = {
              ["<M-a>"] = {
                "sidekick_send",
                mode = { "n", "i" },
              },
            },
          },
        },
      },
    },
  },
}
