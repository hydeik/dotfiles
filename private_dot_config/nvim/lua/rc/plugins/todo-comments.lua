-- [todo-comments.nvim](https://github.com/folke/todo-comments.nvim)
--
-- Highlight, list and search todo comments in your project
--
return {
  "folke/todo-comments.nvim",
  requires = { "nvim-lua/plenary.nvim" },
  cmd = { "TodoQuickFix", "TodoLocList", "TodoTelescope", "TodoTrouble" },
  event = { "BufReadPost" },
  config = function()
    require("todo-comments").setup {
      keywords = {
        TODO = { alt = { "WIP" } },
      },
    }
  end
}
