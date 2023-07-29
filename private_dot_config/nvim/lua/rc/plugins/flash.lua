return {
  -- Navigate your code with search labels, enhanced character motions and Treesitter integration
  "folke/flash.nvim",
  event = "VeryLazy",
  dependencies = {
    "rapan931/lasterisk.nvim",
  },
  opts = {},
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
        "s",
        mode = { "n", "o", "x" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "o", "x" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = { "o" },
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Treesitter Search",
      },
      {
        "<C-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
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
          require("lasterisk").search { is_whole = false }
          vim.schedule(search_reg)
          return "<C-\\><C-N>"
        end,
        mode = { "x" },
        expr = true,
        desc = "Search cword",
      },
    }
  end,
}
