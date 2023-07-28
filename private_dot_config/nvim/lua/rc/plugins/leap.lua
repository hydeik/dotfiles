return {
  {
    -- Leap is a general-purpose motion plugin for Neovim, with the ultimate goal of establishing
    -- a new standard interface for moving around in the visible area in Vim-like modal editors.
    "ggandor/leap.nvim",
    enabled = false,
    dependencies = {
      "tpope/vim-repeat",
      {
        "ggandor/flit.nvim",
        keys = function()
          ---@type LazyKeys[]
          local ret = {}
          for _, key in ipairs { "f", "F", "t", "T" } do
            ret[#ret + 1] = { key, mode = { "n", "x", "o" }, desc = key }
          end
          return ret
        end,
        config = {
          labeled_modes = "nx",
        },
      },
    },
    -- event = "VeryLazy",
    keys = {
      { "ss", "<Plug>(leap-forward-to)", mode = { "n", "x", "o" }, desc = "Leap forward to" },
      { "sS", "<Plug>(leap-backward-to)", mode = { "n", "x", "o" }, desc = "Leap backward to" },
      { "SS", "<Plug>(leap-cross-window)", mode = { "n", "x", "o" }, desc = "Leap cross window" },
    },
    config = true,
  },
  {
    -- Leap onto a specified search pattern.
    "atusy/leap-search.nvim",
    enabled = false,
    dependencies = {
      "leap.nvim",
      "rapan931/lasterisk.nvim",
    },
    keys = function()
      ---@param backward boolean?
      local search = function(backward)
        local pattern = vim.fn.getreg "/"
        if vim.o.hlsearch then
          vim.o.hlsearch = false
          vim.o.hlsearch = true
        end
        local leapable = require("leap-search").leap(pattern, {}, { backward = backward })
        if not leapable then
          -- fallback to default search
          return vim.fn.search(pattern, backward and "b" or "")
        end
      end

      local search_win = function()
        local pattern = vim.fn.getreg "/"
        require("leap-search").leap(pattern, {}, { target_windows = { vim.api.nvim_get_current_win() } })
      end

      local search_ref = function()
        local ref = require("illuminate.reference").buf_get_references(vim.api.nvim_get_current_buf())
        if not ref or #ref == 0 then
          return false
        end
        local targets = {}
        for _, v in pairs(ref) do
          table.insert(targets, {
            pos = { v[1][1] + 1, v[1][2] + 1 },
          })
        end
        require("leap").leap { targets = targets, target_windows = { vim.api.nvim_get_current_win() } }
        return true
      end

      return {
        {
          "gn",
          function()
            search()
          end,
          desc = "Leap search next",
        },
        {
          "gN",
          function()
            search(true)
          end,
          desc = "Leap search prev",
        },
        {
          "*",
          function()
            require("lasterisk").search()
            search_win()
          end,
          desc = "Search cword",
        },
        {
          "*",
          function()
            require("lasterisk").search { is_whole = false }
            vim.schedule(search_win)
            return "<C-\\><C-N>"
          end,
          mode = { "x" },
          expr = true,
          desc = "Search cword",
        },
        {
          "g*",
          function()
            require("lasterisk").search { is_whole = false }
            search_win()
          end,
          desc = "Search cword",
        },
        {
          "#",
          function()
            if search_ref() then
              return
            end
            require("lasterisk").search()
            search_win()
          end,
          desc = "Search cword (ref)",
        },
        {
          "#",
          function()
            require("lasterisk").search { is_whole = false }
            vim.schedule(search_win)
            return "<C-\\><C-N>"
          end,
          mode = { "x" },
          expr = true,
          desc = "Search cword",
        },
        {
          "g#",
          function()
            require("lasterisk").search { is_whole = false }
            search_win()
          end,
          desc = "Search cword",
        },
      }
    end,
  },
}
