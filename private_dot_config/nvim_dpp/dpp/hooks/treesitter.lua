--- Configure nvim-treesitter

-- lua_source {{{
require("nvim-treesitter.configs").setup {
  -- one of 'all', 'language', or a list of languages
  ensure_installed = "all",
  sync_install = false,
  auto_install = true,
  ignore_install = { "haskell", "elixir", "php", "phpdoc" },
  -- [[ Highlight ]]
  highlight = {
    enable = true,
    disable = function()
      -- check if 'filetype' option includes 'chezmoitmpl'
      if string.find(vim.bo.filetype, "chezmoitmpl") then
        return true
      end
    end,
    additional_vim_regex_highlighting = false,
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
  -- [[ Indent ]]
  indent = {
    enable = true,
  },
  -- [[ Text objects ]]
  textobjects = {
    select = {
      enable = true,
      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = { query = "@function.outer", desc = "Select outer part of a function region" },
        ["if"] = { query = "@function.inner", desc = "Select inner part of a function region" },
        ["ac"] = { query = "@class.outer", desc = "Select outer part of a class region" },
        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
        ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>a"] = { query = "@parameter.inner", desc = "Swap the argument with the next one" },
      },
      swap_previous = {
        ["<leader>A"] = { query = "@parameter.inner", desc = "Swap the argument with the previous one" },
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]f"] = { query = "@function.outer", desc = "Next function start" },
        ["]c"] = { query = "@class.outer", desc = "Next class start" },
        ["]a"] = { query = "@parameter.inner", desc = "Next parameter start" },
        ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
        ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
      },
      goto_next_end = {
        ["]F"] = { query = "@function.outer", desc = "Next function end" },
        ["]C"] = { query = "@class.outer", desc = "Next class end" },
        ["]A"] = { query = "@parameter.inner", desc = "Next parameter end" },
      },
      goto_previous_start = {
        ["[f"] = { query = "@function.outer", desc = "Previous function start" },
        ["[c"] = { query = "@class.outer", desc = "Previous class start" },
        ["[a"] = { query = "@parameter.inner", desc = "Previous parameter start" },
        ["[s"] = { query = "@scope", query_group = "locals", desc = "Previous scope" },
        ["[z"] = { query = "@fold", query_group = "folds", desc = "Previous fold" },
      },
      goto_previous_end = {
        ["[F"] = { query = "@function.outer", desc = "Previous function end" },
        ["[C"] = { query = "@class.outer", desc = "Previous class end" },
        ["[A"] = { query = "@parameter.inner", desc = "Previous parameter end" },
      },
    },
  },
}

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

-- }}}
