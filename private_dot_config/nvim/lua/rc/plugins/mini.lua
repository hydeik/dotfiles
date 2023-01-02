local M = {
  "echasnovski/mini.nvim",
  event = "VeryLazy",
}

M.bufremove = function()
  require("mini.bufremove").setup {}
end

M.surround = function()
  require("mini.surround").setup {
    mappings = {
      add = "<Leader>sa", -- Add surrounding in Normal and Visual modes
      delete = "<Leader>sd", -- Delete surrounding
      find = "<Leader>sf", -- Find surrounding (to the right)
      find_left = "<Leader>sF", -- Find surrounding (to the left)
      jhighlight = "<Leader>sh", -- Highlight surrounding
      replace = "<Leader>sr", -- Replace surrounding
      update_n_lines = "<Leader>sn", -- Update `n_lines`
      suffix_last = "l", -- Suffix to search with "prev" method
      suffix_next = "n", -- Suffix to search with "next" method
    },
  }
end

M.trailspace = function()
  require("mini.trailspace").setup {}
end

M.init = function()
  vim.keymap.set("n", "<leader>bd", function()
    require("mini.bufremove").delete(0, false)
  end, { desc = "Delete buffer" })
  vim.keymap.set("n", "<leader>bD", function()
    require("mini.bufremove").delete(0, true)
  end, { desc = "Delete buffer (force)" })
end

M.config = function()
  M.bufremove()
  M.surround()
  M.trailspace()
end

return M
