return {
  {
    "yannvanhalewyn/jujutsu.nvim",
    enabled = false, -- doesn't work in nushell
    cmd = { "JJ" },
    opts = {
      diff_preset = "difftastic", -- "difftastic" | "diffview" | "codediff" | "none"
      help_position = "bottom_right", -- "center" | "bottom_right"
      -- Custom keymaps in the log view
      keymap = {
        -- Structured format (recommended)
        q = { cmd = "quit", desc = "Close window" },
        R = { cmd = "refresh", desc = "Refresh log" },
        d = { cmd = "describe", desc = "Edit description" },

        -- Map to custom functions
        ["<C-d>"] = {
          cmd = function()
            local jj = require "jujutsu-nvim"
            jj.with_change_at_cursor(function(change_id)
              vim.notify("Custom diff command: " .. change_id)
            end)
          end,
          desc = "Custom diff",
        },
      },
    },
    config = function(_, opts)
      require("jujutsu-nvim").setup(opts)
    end,
  },
  {
    "MrDwarf7/lazyjui.nvim",
    keys = {
      {
        "<Space>gj",
        function()
          require("lazyjui").open()
        end,
        desc = "Jujutus UI",
      },
    },
  },
}
