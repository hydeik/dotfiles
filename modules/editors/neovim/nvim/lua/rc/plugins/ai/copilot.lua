return {
  -- copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = { "Copilot" },
    event = { "BufReadPost" },
    build = ":Copilot auth",
    opts = {
      suggestion = {
        enabled = not vim.g.vimrc_use_ai_cmp,
        auto_trigger = true,
        hide_during_competion = vim.g.vimrc_use_ai_cmp,
        keymap = {
          accept = false, -- handled by completin engine
          next = "<Up>",
          prev = "<Down>",
        },
      },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
    -- add ai_accept action
    {
      "zbirenbaum/copilot.lua",
      opts = function()
        require("rc.utils.cmp").ai_accept = function()
          if require("copilot.suggestion").is_visible() then
            require("rc.utils").create_undo()
            require("copilot.suggestion").accept()
            return true
          end
        end
      end,
    },
    -- Completion engine
    vim.g.vimrc_use_ai_cmp
        and {
          -- copilot source for blink.cmp
          {
            "saghen/blink.cmp",
            optional = true,
            dependencies = { "giuxtaposition/blink-cmp-copilot" },
            opts = {
              sources = {
                default = { "copilot" },
                providers = {
                  copilot = {
                    name = "copilot",
                    module = "blink-cmp-copilot",
                    kind = "Copilot",
                    score_offset = 100,
                    async = true,
                  },
                },
              },
            },
          },
        }
      or nil,
  },
}
