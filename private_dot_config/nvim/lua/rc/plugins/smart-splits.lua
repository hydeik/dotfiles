-- Smart, directional Neovim and tmux split resizing and navigation.
-- Think about splits in terms of "up/down/left/right".
return {
  "mrjones2014/smart-splits.nvim",
  lazy = true,
  init = function()
    -- moving between splits
    vim.keymap.set("n", "<M-h>", function()
      require("smart-splits").move_cursor_left()
    end, { desc = "Move Window Left" })
    vim.keymap.set("n", "<M-j>", function()
      require("smart-splits").move_cursor_down()
    end, { desc = "Move Window Down" })
    vim.keymap.set("n", "<M-k>", function()
      require("smart-splits").move_cursor_up()
    end, { desc = "Move Window Up" })
    vim.keymap.set("n", "<M-l>", function()
      require("smart-splits").move_cursor_right()
    end, { desc = "Move Window Right" })
    -- resize splits
    vim.keymap.set("n", "<C-M-h>", function()
      require("smart-splits").resize_left()
    end, { desc = "Resize Window Left" })
    vim.keymap.set("n", "<C-M-j>", function()
      require("smart-splits").resize_down()
    end, { desc = "Resize Window Left" })
    vim.keymap.set("n", "<C-M-k>", function()
      require("smart-splits").resize_up()
    end, { desc = "Resize Window Left" })
    vim.keymap.set("n", "<C-M-l>", function()
      require("smart-splits").resize_right()
    end, { desc = "Resize Window Left" })
  end,
  config = true,
}
