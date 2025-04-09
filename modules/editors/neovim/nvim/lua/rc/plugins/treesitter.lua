return {
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<M-v>", desc = "Increment Selection", mode = { "x", "n" } },
        { "<M-V>", desc = "Decrement Selection", mode = "x" },
      },
    },
  },

  -- Nvim Treesitter configurations and abstraction layer
  {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- the last release is way too old and doesn't work on Windows
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    keys = {
      { "<M-v>", desc = "Increment Selection" },
      { "<M-V>", desc = "Decrement Selection", mode = "x" },
    },
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
    opts_extend = { "ensure_installed" },
    ---@type TSConfig
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      -- one of 'all', 'language', or a list of languages
      ensure_installed = {
        "asm",
        "bash",
        "c",
        "css",
        "csv",
        "diff",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "just",
        "lua",
        "luadoc",
        "luap",
        "make",
        "markdown",
        "markdown_inline",
        "printf",
        "query",
        "regex",
        "scss",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
      },
      sync_install = false,
      auto_install = true,
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
          scope_incremental = false, -- increment to the upper scope (as defined in locals.scm)
          node_decremental = "<M-V>", -- decrement to the previous node
        },
      },
      -- [[ Indent ]]
      indent = {
        enable = true,
      },
      -- [[ Text objects ]]
      textobjects = {

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
        opts.ensure_installed = require("rc.utils").list_unique(opts.ensure_installed)
      end
      require("nvim-treesitter.configs").setup(opts)
      -- Code folding with treesitter
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    enabled = true,
    config = function()
      -- If treesitter is already loaded, we need to run config again for textobjects
      local lazy_utils = require "rc.utils.lazy"
      if lazy_utils.is_loaded "nvim-treesitter" then
        local opts = lazy_utils.get_plugin_opts "nvim-treesitter"
        require("nvim-treesitter.configs").setup {
          textobjects = opts.textobjects,
        }
      end

      -- When in diff mode, we want to use the default
      -- vim text objects c & C instead of the treesitter ones.
      local move = require "nvim-treesitter.textobjects.move" ---@type table<string,fun(...)>
      local configs = require "nvim-treesitter.configs"
      for name, fn in pairs(move) do
        if name:find "goto" == 1 then
          move[name] = function(q, ...)
            if vim.wo.diff then
              local config = configs.get_module("textobjects.move")[name] ---@type table<string,string>
              for key, query in pairs(config or {}) do
                if q == query and key:find "[%]%[][cC]" then
                  vim.cmd("normal! " .. key)
                  return
                end
              end
            end
            return fn(q, ...)
          end
        end
      end
    end,
  },

  -- -- Automatically add closing tags for HTML and JSX
  -- {
  --   "windwp/nvim-ts-autotag",
  --   event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  --   opts = {},
  -- },
  -- {
  --   "folke/twilight.nvim",
  --   cmd = { "Twilight", "TwilightEnable", "TwilightDisable" },
  -- },
}
