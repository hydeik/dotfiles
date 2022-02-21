local M = {}
-- vim.cmd [[packadd nvim-treesitter-refactor]]
-- vim.cmd [[packadd nvim-treesitter-textobjects]]
-- vim.cmd [[packadd nvim-ts-rainbow]]
-- vim.cmd [[packadd nvim-ts-context-commentstring]]

function M.setup() end

function M.config()
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
    -- [[ Refactor ]]
    refactor = {
      highlight_definitions = { enable = true },
      highlight_current_scope = { enable = false },
      smart_rename = {
        enable = true,
        keymaps = {
          smart_rename = "grr", -- mapping to rename reference under cursor
        },
      },
      navigation = {
        enable = true,
        keymaps = {
          goto_definition = "gnd", -- mapping to go to definition of symbol under cursor
          list_definitions = "gnD", -- mapping to list all definitions in current file
        },
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
      swap = {
        enable = true,
        swap_next = { ["<Leader>s"] = "@parameter.inner" },
        swap_previous = { ["<Leader>S"] = "@parameter.inner" },
      },
    },
    -- [[ Rainbow ]]
    rainbow = { enable = true, extended_mode = true, max_file_lines = 1000 },
    -- [[ Context commentstring ]]
    context_commentstring = { enable = true },
  }

  -- [[ Treesitter Unit ]]
  vim.keymap.set("x", "iu", ":lua require('treesitter-unit').select()<CR>", { silent = true })
  vim.keymap.set("x", "au", ":lua require('treesitter-unit').select(true)<CR>", { silent = true })
  vim.keymap.set("o", "iu", ":<C-u>lua require('treesitter-unit').select()<CR>", { silent = true })
  vim.keymap.set("o", "au", ":<C-u>lua require('treesitter-unit').select(true)<CR>", { silent = true })
end

return M
