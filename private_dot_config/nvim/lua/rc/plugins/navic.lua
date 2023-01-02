return {
  -- Simple winbar/statusline plugin that shows your current code context
  "SmiteshP/nvim-navic",
  config = function()
    require("nvim-navic").setup {
      separator = " ",
      highlight = true,
      depth_limit = 5,
    }
  end,
}
