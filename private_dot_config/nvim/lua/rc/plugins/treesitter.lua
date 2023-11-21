return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- the last release is way too old and doesn't work on Windows
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        init = function()
          -- PERF: no need to load the plugin, if we only need its queries for mini.ai
          local plugin = require("lazy.core.config").spec.plugins["nvim-treesitter"]
          local opts = require("lazy.core.plugin").values(plugin, "opts", false)
          local enabled = false
          if opts.textobjects then
            for _, mod in ipairs { "move", "select", "swap", "lsp_interop" } do
              if opts.textobjects[mod] and opts.textobjects[mod].enable then
                enabled = true
                break
              end
            end
          end
          if not enabled then
            require("lazy.core.loader").disable_rtp_plugin "nvim-treesitter-textobjects"
          end
        end,
      },
      { "mrjones2014/nvim-ts-rainbow" },
      { "JoosepAlviste/nvim-ts-context-commentstring" },
    },
    ---@type TSConfig
    opts = {
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
      -- [[ Rainbow ]]
      rainbow = { enable = true, extended_mode = true, max_file_lines = 1000 },
    },
    ---@param opts TSConfig
    config = function(_, opts)
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
  {
    "folke/twilight.nvim",
    cmd = { "Twilight", "TwilightEnable", "TwilightDisable" },
  },
}
