-- lua_add {{{

-- moving between splits
vim.keymap.set(
  "n",
  "<M-h>",
  function()
    require("smart-splits").move_cursor_left()
  end,
  { desc = "Move Window Left" }
)

vim.keymap.set(
  "n",
  "<M-j>",
  function()
    require("smart-splits").move_cursor_down()
  end,
  { desc = "Move Window Down" }
)

vim.keymap.set(
  "n",
  "<M-k>",
  function()
    require("smart-splits").move_cursor_up()
  end,
  { desc = "Move Window Up" }
)

vim.keymap.set(
  "n",
  "<M-l>",
  function()
    require("smart-splits").move_cursor_right()
  end,
  { desc = "Move Window Right" }
)

-- resize splits
vim.keymap.set(
  "n",
  "<C-M-h>",
  function()
    require("smart-splits").resize_left()
  end,
  { desc = "Resize Window Left" }
)

vim.keymap.set(
  "n",
  "<C-M-j>",
  function()
    require("smart-splits").resize_down()
  end,
  { desc = "Resize Window Down" }
)

vim.keymap.set(
  "n",
  "<C-M-k>",
  function()
    require("smart-splits").resize_up()
  end,
  { desc = "Resize Window Up" }
)

vim.keymap.set(
  "n",
  "<C-M-l>",
  function()
    require("smart-splits").resize_right()
  end,
  { desc = "Resize Window Right" }
)

-- swapping buffers between windows
vim.keymap.set(
  "n",
  "<leader><leader>h",
  function()
    require("smart-splits").swap_buf_left()
  end,
  { desc = "Swap Buffer Left" }
)

vim.keymap.set(
  "n",
  "<leader><leader>k",
  function()
    require("smart-splits").swap_buf_down()
  end,
  { desc = "Swap Buffer Down" }
)

vim.keymap.set(
  "n",
  "<leader><leader>j",
  function()
    require("smart-splits").swap_buf_up()
  end,
  { desc = "Swap Buffer Up" }
)

vim.keymap.set(
  "n",
  "<leader><leader>l",
  function()
    require("smart-splits").swap_buf_right()
  end,
  { desc = "Swap Buffer Right" }
)

-- }}}
