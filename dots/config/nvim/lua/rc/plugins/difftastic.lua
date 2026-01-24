return {
  "clabby/difftastic.nvim",
  cmd = { "Difft", "DifftUpdate" },
  opts = {
    download = true, -- Auto-download pre-built binary (default: false)
  },
  config = function(_, opts)
    require("difftastic-nvim").setup(opts)
  end,
}
