return {
  -- Highlight, list and search todo comments in your projects
  "folke/todo-comments.nvim",
  lazy = true,
  cmd = { "TodoTrouble", "TodoTelescope" },
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  keys = {
    {
      "]t",
      function()
        require("todo-comments").jump_next()
      end,
      desc = "Next todo comment",
    },
    {
      "[t",
      function()
        require("todo-comments").jump_prev()
      end,
      desc = "Previous todo comment",
    },
    { "<Space>xt", "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
    {
      "<Space>xT",
      "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>",
      desc = "Todo/Fix/Fixme (Trouble)",
    },
  },
  opts = {},
}
