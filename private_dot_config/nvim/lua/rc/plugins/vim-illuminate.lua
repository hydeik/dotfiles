-- illuminate.vim - (Neo)Vim plugin for automatically highlighting other uses
-- of the word under the cursor using either LSP, Tree-sitter, or regex matching.
return {
  "RRethy/vim-illuminate",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    delay = 200,
  },
  config = function(_, opts)
    require("illuminate").configure(opts)
  end,
}
