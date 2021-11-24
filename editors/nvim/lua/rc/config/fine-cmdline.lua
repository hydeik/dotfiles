local M = {}

function M.setup()
  local keymap = require "rc.core.keymap"
  keymap.nnoremap { "<C-p>", "<cmd>lua require'fine-cmdline'.open()<CR>" }
  -- If you'd like to remap `:` instead,
  -- keymap.nnoremap { ":", "<cmd>lua require'fine-cmdline'.open()<CR>" }
end

function M.config()
  require("fine-cmdline").setup {
    cmdline = {
      enable_keymaps = false,
    },
    popup = {
      position = {
        row = "10%",
        col = "50%",
      },
      size = {
        width = "60%",
        height = 1,
      },
      border = {
        style = "rounded",
        highlight = "FloatBorder",
      },
      win_options = {
        winhighlight = "Normal:Normal",
      },
    },
    hooks = {
      -- before_mount = function(input)
      --   input.input_props.prompt = ""
      -- end,
      set_keymaps = function(imap, _)
        local fn = require("fine-cmdline").fn
        imap("<Esc>", fn.close)
        imap("<C-c>", fn.close)
        imap("jj", fn.close)
        imap("<C-p>", fn.up_history)
        imap("<C-n>", fn.down_history)
      end,
    },
  }
end

return M
