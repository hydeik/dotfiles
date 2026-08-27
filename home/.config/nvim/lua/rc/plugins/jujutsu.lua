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
    opts = {
      -- Optionally (default):
      border = {
        -- Use custom set of border chars (must be 8 long)
        -- chars = { "", "", "", "", "", "", "", "" }, -- either set all to empty to remove the entire outer border (or nil/{})
        chars = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        thickness = 0, -- This handles the border of the 'outer' window it's nested inside, generally this is invisible
        -- See `:h nvim_win_set_hl_ns()` and associated docs for more details
        -- previous option was: "FloatBorder:LazyJuiBorder,NormalFloat:LazyJuiFloat", -- up to you how to set
        winhl_str = "",
      },
    },
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
