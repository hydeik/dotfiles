return {
  {
    "TheNoeTrevino/haunt.nvim",
    -- default config: change to your liking, or remove it to use defaults
    ---@class HauntConfig
    opts = {
      sign = "󱙝",
      sign_hl = "DiagnosticInfo",
      virt_text_hl = "HauntAnnotation",
      annotation_prefix = " 󰆉 ",
      line_hl = nil,
      virt_text_pos = "eol",
      data_dir = nil,
      picker_keys = {
        delete = { key = "d", mode = { "n" } },
        edit_annotation = { key = "a", mode = { "n" } },
      },
    },
    keys = {
      -- anotation
      {
        "<space>ha",
        function()
          require("haunt.api").annotate()
        end,
        desc = "Annotate",
      },
      {
        "<space>hd",
        function()
          require("haunt.api").delete()
        end,
        desc = "Delete bookmark",
      },
      {
        "<space>hD",
        function()
          require("haunt.api").clear_all()
        end,
        desc = "Delete all bookmarks",
      },
      {
        "<space>ht",
        function()
          require("haunt.api").toggle_annotation()
        end,
        desc = "Toggle annotation",
      },
      {
        "<space>hT",
        function()
          require("haunt.api").toggle_all_lines()
        end,
        desc = "Toggle all annotations",
      },
      -- move
      {
        "<space>hn",
        function()
          require("haunt.api").next()
        end,
        desc = "Next bookmark",
      },
      {
        "<space>hp",
        function()
          require("haunt.api").prev()
        end,
        desc = "Previous bookmark",
      },
      -- picker
      {
        "<space>hl",
        function()
          require("haunt.picker").show()
        end,
        desc = "Show Picker",
      },
      -- quickfix
      {
        "<space>hq",
        function()
          require("haunt.api").to_quickfix { current_buffer = true }
        end,
        desc = "Send hauntings to quickfix (buffer)",
      },
      {
        "<space>hQ",
        function()
          require("haunt.api").to_quickfix()
        end,
        desc = "Send Hauntings to Quickfix (all)",
      },
      -- yank
      {
        "<space>hy",
        function()
          require("haunt.api").yank_locations { current_buffer = true }
        end,
        desc = "Send Hauntings to Clipboard (buffer)",
      },
      {
        "<space>hY",
        function()
          require("haunt.api").yank_locations()
        end,
        desc = "Send Hauntings to Clipboard (all)",
      },
    },
  },
  -- sidekick.nvim integration
  {
    "folke/sidekick.nvim",
    optional = true,
    opts = {
      cli = {
        prompts = {
          haunt_all = function()
            return require("haunt.sidekick").get_locations()
          end,
          haunt_buffer = function()
            return require("haunt.sidekick").get_locations { current_buffer = true }
          end,
        },
      },
    },
  },
}
