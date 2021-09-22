local M = {}

function M.setup()
  -- Custom keybindings
  local nnoremap = vim.keymap.nnoremap

  nnoremap {
    "<M-h>",
    "<cmd>lua require('tmux').move_left()<CR>",
    silent = true,
    nowait = true,
  }
  nnoremap {
    "<M-j>",
    "<cmd>lua require('tmux').move_bottom()<CR>",
    silent = true,
    nowait = true,
  }
  nnoremap {
    "<M-k>",
    "<cmd>lua require('tmux').move_top()<CR>",
    silent = true,
    nowait = true,
  }
  nnoremap {
    "<M-l>",
    "<cmd>lua require('tmux').move_right()<CR>",
    silent = true,
    nowait = true,
  }

  nnoremap {
    "<C-M-h>",
    "<cmd>lua require('tmux').resize_left()<CR>",
    silent = true,
    nowait = true,
  }
  nnoremap {
    "<C-M-j>",
    "<cmd>lua require('tmux').resize_bottom()<CR>",
    silent = true,
    nowait = true,
  }
  nnoremap {
    "<C-M-k>",
    "<cmd>lua require('tmux').resize_top()<CR>",
    silent = true,
    nowait = true,
  }
  nnoremap {
    "<C-M-l>",
    "<cmd>lua require('tmux').resize_right()<CR>",
    silent = true,
    nowait = true,
  }
end

function M.config()
  require("tmux").setup {
    navigation = { enable_default_keybindings = false },
    resize = {
      enable_default_keybindings = false,
      resize_step_x = 2,
      resize_step_y = 2,
    },
  }
end

return M
