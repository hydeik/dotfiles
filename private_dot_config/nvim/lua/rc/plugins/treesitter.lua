return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- the last release is way too old and doesn't work on Windows
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
    init = function(plugin)
      -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
      -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
      -- no longer trigger the **nvim-treesitter** module to be loaded in time.
      -- Luckily, the only things that those plugins need are the custom queries, which we make available
      -- during startup.
      require("lazy.core.loader").add_to_rtp(plugin)
      require "nvim-treesitter.query_predicates"
    end,
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-textobjects" },
    },
    opts_extend = { "ensure_installed" },
    ---@type TSConfig
    opts = {
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
        -- Use mini.ai for selection
        -- select = {
        --   enable = true,
        --   -- Automatically jump forward to textobj, similar to targets.vim
        --   lookahead = true,
        --   keymaps = {
        --     -- You can use the capture groups defined in textobjects.scm
        --     ["af"] = { query = "@function.outer", desc = "Select outer part of a function region" },
        --     ["if"] = { query = "@function.inner", desc = "Select inner part of a function region" },
        --     ["ac"] = { query = "@class.outer", desc = "Select outer part of a class region" },
        --     ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
        --     ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
        --   },
        -- },
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
    },
    ---@param opts TSConfig
    config = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        -- remove duplicate entries
        opts.ensure_installed = requre("rc.util").list_unique(opts.ensure_installed)
      end
      require("nvim-treesitter.configs").setup(opts)
      -- Code folding with treesitter
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    end,
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    opts = {},
    init = function()
      vim.g.skip_ts_context_commentstring_module = true
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPre" },
    enabled = false,
    config = true,
  },
  -- Automatically add closing tags for HTML and JSX
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    opts = {},
  },
  {
    "folke/twilight.nvim",
    cmd = { "Twilight", "TwilightEnable", "TwilightDisable" },
  },
}
