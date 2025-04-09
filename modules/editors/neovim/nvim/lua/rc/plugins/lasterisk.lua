return {
  -- vim-asterisk written in lua
  "rapan931/lasterisk.nvim",
  lazy = false,
  dependencies = { "folke/flash.nvim" },
  keys = function(_, _)
    local search_reg = function()
      local pattern = vim.fn.getreg "/"
      require("flash").jump {
        -- search = { multi_window = false },
        search = { mode = "search", multi_window = false },
        pattern = pattern,
      }
    end

    return {
      {
        "*",
        function()
          require("lasterisk").search()
          search_reg()
        end,
        desc = "Search cword",
      },
      {
        "*",
        function()
          require("lasterisk").search { is_whole = false, silent = false }
          vim.schedule(search_reg)
          return "<C-\\><C-N>"
        end,
        mode = { "x" },
        expr = true,
        desc = "Search cword",
      },
    }
  end,
  config = function(_, _) end,
}
