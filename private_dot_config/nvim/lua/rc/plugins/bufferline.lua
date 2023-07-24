-- A blazing fast and easy to configure neovim statusline plugin written in pure lua.
return {
  "akinsho/bufferline.nvim",
  enabled = false,
  event = "VeryLazy",
  keys = {
    { "<S-h>", "<cmd>BufferLineCyclePrev<CR>", desc = "Prev buffer" },
    { "<S-l>", "<cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
    { "[b", "<cmd>BufferLineCyclePrev<CR>", desc = "Prev buffer" },
    { "]b", "<cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
  },
  opts = {
    options = {
      close_command = function(n)
        require("mini.bufremove").delete(n, false)
      end,
      right_mouse_command = function(n)
        require("mini.bufremove").delete(n, false)
      end,
      indicator = {
        icon = "▎",
        style = "icon",
      },
      diagnostics = "nvim_lsp",
      diagnostics_indicator = function(_, _, diagnostics_dict, _)
        local icons = require("rc.core.config").icons.diagnostics
        local tmp = {
          diagnostics_dict.error and icons.Error .. diagnostics_dict.error or "",
          diagnostics_dict.warning and icons.Warn .. diagnostics_dict.warning or "",
        }
        return table.concat(tmp, " ")
      end,
      always_show_bufferline = true,
      hover = {
        enabled = true,
        delay = 200,
        reveal = { "close" },
      },
      offsets = {
        {
          filetype = "neo-tree",
          text = "Neo-tree",
          highlight = "Directory",
          text_align = "left",
        },
      },
    },
  },
}
