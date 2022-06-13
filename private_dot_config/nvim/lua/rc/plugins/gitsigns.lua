-- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
--
-- Git integration for buffers
--
return {
  "lewis6991/gitsigns.nvim",
  branch = "main",
  event = { "FocusLost", "CursorHold" },
  requires = { "nvim-lua/plenary.nvim" },
  config = function()
    require("gitsigns").setup {
      signs = {
        add = { hl = "DiffAdd", text = "│", numhl = "GitSignsAddNr" },
        change = { hl = "DiffChange", text = "│", numhl = "GitSignsChangeNr" },
        delete = { hl = "DiffDelete", text = "_", numhl = "GitSignsDeleteNr" },
        topdelete = { hl = "DiffDelete", text = "‾", numhl = "GitSignsDeleteNr" },
        changedelete = { hl = "DiffChange", text = "~", numhl = "GitSignsChangeNr" },
      },
      numhl = true,
      word_diff = true,
    }
  end,
}
