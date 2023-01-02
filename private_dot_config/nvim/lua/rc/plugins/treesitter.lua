local M = {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = "BufRead",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "p00f/nvim-ts-rainbow",
    "JoosepAlviste/nvim-ts-context-commentstring",
    "yioneko/nvim-yati",
    -- { "mizlan/iswap.nvim", cmd = { "ISwap", "ISwapWith" } },
    "David-Kunz/treesitter-unit",
  },
}

M.init = function()
  -- iswap
  -- vim.keymap.set("n", "<Leader>s", "<Cmd>ISwapWith<CR>",
  --   { silent = true, desc = "Select and swap function arguments." })
  -- treesitter_unit
  vim.keymap.set("x", "iu", ":lua require('treesitter-unit').select()<CR>", { silent = true })
  vim.keymap.set("x", "au", ":lua require('treesitter-unit').select(true)<CR>", { silent = true })
  vim.keymap.set("o", "iu", ":<C-u>lua require('treesitter-unit').select()<CR>", { silent = true })
  vim.keymap.set("o", "au", ":<C-u>lua require('treesitter-unit').select(true)<CR>", { silent = true })
end

M.config = function()
  require("nvim-treesitter.configs").setup {
    -- one of 'all', 'language', or a list of languages
    ensure_installed = "all",
    ignore_install = { "haskell", "elixir", "php", "phpdoc" },
    -- [[ Highlight ]]
    highlight = {
      enable = true,
      disable = {},
      custom_captures = {
        -- ["foo.bar"] = "Identifier"
      },
    },
    -- [[ Incremental selection ]]
    incremental_selection = {
      enable = true,
      disable = {},
      keymaps = {
        -- mappings for incremental selection (visual mappings)
        init_selection = "<M-v>", -- maps in normal mode to init the node/scope selection
        node_incremental = "<M-v>", -- increment to the upper named parent
        scope_incremental = "<C-M-v>", -- increment to the upper scope (as defined in locals.scm)
        node_decremental = "<M-V>", -- decrement to the previous node
      },
    },
    -- [[ Text objects ]]
    textobjects = {
      select = {
        enable = true,
        disable = {},
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["aC"] = "@class.outer",
          ["iC"] = "@class.inner",
          ["ac"] = "@conditional.outer",
          ["ic"] = "@conditional.inner",
          ["ae"] = "@block.outer",
          ["ie"] = "@block.inner",
          ["al"] = "@loop.outer",
          ["il"] = "@loop.inner",
          ["iS"] = "@statement.inner",
          ["aS"] = "@statement.outer",
          ["am"] = "@call.outer",
          ["im"] = "@call.inner",
          ["ad"] = "@comment.outer",
          ["id"] = "@comment.inner",
        },
      },
      -- swap = {
      --   enable = true,
      --   swap_next = { ["<Leader>s"] = "@parameter.inner" },
      --   swap_previous = { ["<Leader>S"] = "@parameter.inner" },
      -- },
    },
    -- [[ Rainbow ]]
    rainbow = { enable = true, extended_mode = true, max_file_lines = 1000 },
    -- [[ Context commentstring ]]
    context_commentstring = { enable = true },
  }

  -- Code folding with treesitter
  vim.opt.foldmethod = "expr"
  vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
end

return M
