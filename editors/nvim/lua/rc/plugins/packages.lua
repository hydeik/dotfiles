local M = {}

function M.load_plugins(use, _)
  -- [[ Fundamental plugins ]]
  -- A use-package inspired plugin manager for Neovim.
  -- (Packer can manage itself as an optional plugin)
  use { "wbthomason/packer.nvim", opt = true }

  -- Speed up loading Lua modules in Neovim to improve startup time.
  use { "lewis6991/impatient.nvim" }

  -- plenary: full; complete; entire; absolute; unqualified.
  use { "nvim-lua/plenary.nvim", module = "plenary" }

  -- An implementation of the popup API from vim in Neovim. Hope to upstream when complete.
  use { "nvim-lua/popup.nvim", module = "popup" }

  -- Fix CursorHold performance
  -- TODO: remove it if https://github.com/neovim/neovim/issues/12587 is fixed.
  use {
    "antoinemadec/FixCursorHold.nvim",
    config = [[vim.g.cursorhold_updatetime = 100]],
  }

  -- tmux integration for nvim features pane movement and resizing from within nvim.
  use {
    "aserowy/tmux.nvim",
    module = { "tmux" },
    setup = [[require("rc.config.tmux").setup()]],
    config = [[require("rc.config.tmux").config()]],
  }

  -- [[ UI ]]
  -- Colorschemes
  use { "EdenEast/nightfox.nvim" }
  use { "folke/tokyonight.nvim", opt = true }
  use { "shaunsingh/moonlight.nvim", opt = true }
  use { "shaunsingh/nord.nvim", opt = true }

  -- Icons
  use {
    "kyazdani42/nvim-web-devicons",
    module = "nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup {
        default = true,
      }
    end,
  }

  -- A snazzy bufferline for Neovim
  use {
    "akinsho/nvim-bufferline.lua",
    requires = { "kyazdani42/nvim-web-devicons" },
    event = "BufReadPre",
    config = [[require("bufferline").setup { options = { always_show_bufferline = true } }]],
  }

  -- A fancy, configurable, notification manager for Neovim
  use {
    "rcarriga/nvim-notify",
    module = "notify",
  }

  -- Enter ex-commands in a nice floating input.
  use {
    "VonHeikemen/fine-cmdline.nvim",
    requires = { "MunifTanjim/nui.nvim" },
    module = { "fine-cmdline" },
    setup = [[require("rc.config.fine-cmdline").setup()]],
    config = [[require("rc.config.fine-cmdline").config()]],
  }

  -- Start your search from a more confortable place, say the upper right corner?
  use {
    "VonHeikemen/searchbox.nvim",
    requires = { "MunifTanjim/nui.nvim" },
    module = { "searchbox" },
    setup = [[require("rc.config.searchbox").setup()]],
    config = [[require("rc.config.searchbox").config()]],
  }

  -- Better whitespace highlighting
  use {
    "ntpeters/vim-better-whitespace",
    event = { "BufNewFile", "BufRead" },
    setup = [[require("rc.config.vim-better-whitespace").setup()]],
  }

  -- A file explorer tree for neovim written in lua
  use {
    "kyazdani42/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeRefresh", "NvimTreeFindFile" },
    setup = [[require("rc.config.nvim-tree").setup()]],
    config = [[require("rc.config.nvim-tree").config()]],
  }

  -- [[ Editor ]]
  -- Enable repeating supported plugin maps with "."
  use { "tpope/vim-repeat" }

  -- Even better % navigation and highlight mathching words
  use { "andymass/vim-matchup", event = { "CursorHold" } }

  -- Imporove foldtext for better looks
  use { "lambdalisue/readablefold.vim" }

  -- -- Better glance searched information
  -- use {
  --   "kevinhwang91/nvim-hlslens",
  --   module = { "hlslens" },
  --   setup = [[require("rc.config.hlslens").setup()]],
  --   config = [[require("rc.config.hlslens").config()]],
  -- }

  -- -- Preview the contents of register
  -- use { "tversteeg/registers.nvim" }

  -- Enhanced f/t
  use {
    "hrsh7th/vim-eft",
    keys = {
      { "n", "<Plug>(eft-" },
      { "o", "<Plug>(eft-" },
      { "x", "<Plug>(eft-" },
    },
    setup = [[require("rc.config.vim-eft").setup()]],
  }

  -- Neovim motions on speed!
  use {
    "phaazon/hop.nvim",
    module = { "hop" },
    setup = [[require("rc.config.hop").setup()]],
    config = [[require("rc.config.hop").config()]],
  }

  -- Make blockwise visual mode more useful
  use {
    "kana/vim-niceblock",
    keys = { { "v", "<Plug>(niceblock-" } },
    setup = [[require("rc.config.vim-niceblock").setup()]],
  }

  -- The killring-alike plugin with no default mappings.
  -- (Use this plugin until https://github.com/neovim/neovim/issues/1822 is fixed)
  use {
    "bfredl/nvim-miniyank",
    keys = { { "n", "<Plug>(miniyank-" } },
    setup = [[require("rc.config.miniyank").setup()]],
  }

  -- Enhanced increment/decrement plugin for Neovim.
  use {
    "monaqa/dial.nvim",
    keys = { { "n", "<Plug>(dial-" }, { "v", "<Plug>(dial-" } },
    setup = [[require("rc.config.dial").setup()]],
  }

  -- Preview the content of the registers
  use {
    "tversteeg/registers.nvim",
    branch = "main",
    keys = {
      { "n", '"' },
      { "i", "<C-r>" },
    },
  }

  -- Show keybindings in popup
  use {
    "folke/which-key.nvim",
    config = [[require("rc.config.which-key").config()]],
  }

  -- A high-performance color highlighter for NeoVim
  use {
    "norcalli/nvim-colorizer.lua",
    event = "BufReadPre",
    config = [[require("rc.config.colorizer").config()]],
  }

  -- Breakdown Vim's --startuptime output
  use { "tweekmonster/startuptime.vim", cmd = "StartupTime" }

  -- Text objects & operators
  use { "kana/vim-operator-user" }
  use { "kana/vim-textobj-user" }
  use {
    "kana/vim-operator-replace",
    requires = { "kana/vim-operator-user" },
    keys = {
      { "n", "<Plug>(operator-replace)" },
      { "x", "<Plug>(operator-replace)" },
    },
    setup = function()
      local keymap = require "rc.core.keymap"
      keymap.nmap { "_", "<Plug>(operator-replace)" }
      keymap.xmap { "_", "<Plug>(operator-replace)" }
    end,
  }
  use {
    "machakann/vim-sandwich",
    event = "CursorHold",
    keys = {
      { "n", "<Plug>(operator-sandwich-" },
      { "o", "<Plug>(operator-sandwich-" },
      { "x", "<Plug>(operator-sandwich-" },
      { "n", "<Plug>(textobj-sandwich-" },
      { "o", "<Plug>(textobj-sandwich-" },
      { "x", "<Plug>(textobj-sandwich-" },
    },
    setup = [[require("rc.config.sandwich").setup()]],
    config = [[require("rc.config.sandwich").config()]],
  }

  -- Smart align
  use {
    "junegunn/vim-easy-align",
    keys = { { "n", "<Plug>(EasyAlign)" }, { "v", "<Plug>(EasyAlign)" } },
    setup = [[require("rc.config.vim-easy-align").setup()]],
  }

  -- SKK input method for Japanese
  use {
    "tyru/eskk.vim",
    event = "InsertCharPre",
    config = [[require("rc.config.eskk").config()]],
  }

  -- Better quickfix windowin Neovim, polish old quickfix window
  use { "kevinhwang91/nvim-bqf", branch = "main", ft = { "qf" } }

  -- Perform the replacement in quickfix
  use {
    "thinca/vim-qfreplace",
    ft = { "qf" },
    config = function()
      require("rc.core.autocmd").group("MyAutoCmd", {
        {
          "FileType",
          "qf",
          function()
            vim.api.nvim_buf_set_keymap(0, "n", "R", "<cmd>Qfreplace<CR>", { noremap = true })
          end,
        },
      })
    end,
  }

  -- [[ VCS ]]
  -- Asynchronously control git repositories
  -- { "lambdalisue/gina.vim", cmd = {"Gina"} },

  -- Calling LazyGit from within neovim
  use {
    "kdheepak/lazygit.nvim",
    cmd = { "LazyGit", "LazyGitFilter", "LazyGitConfig" },
    setup = function()
      vim.g.lazygit_floating_window_winblend = 0
      vim.g.lazygit_floating_window_scaling_factor = 0.9
      vim.g.lazygit_floating_window_corner_chars = { "╭", "╮", "╰", "╯" }
      vim.g.lazygit_use_neovim_remote = 0
      require("rc.core.keymap").nnoremap { "<Space>gl", "<cmd>LazyGit<CR>", silent = true }
    end,
  }

  -- Git signs written in pure lua
  use {
    "lewis6991/gitsigns.nvim",
    branch = "main",
    event = { "FocusLost", "CursorHold" },
    requires = { "nvim-lua/plenary.nvim" },
    config = [[require("rc.config.gitsigns").config()]],
  }

  -- Reveal the commit messages under the cursor
  use {
    "rhysd/git-messenger.vim",
    cmd = { "GitMessenger" },
    keys = { { "n", "<Plug>(git-messenger" } },
    setup = function()
      vim.g.git_messenger_no_default_mappings = true
      require("rc.core.keymap").nmap { "<Space>gm", "<Plug>(git-messenger)", silent = true }
    end,
  }

  -- More pleasant editing on commit messsages
  use {
    "rhysd/committia.vim",
    event = { "BufEnter COMMIT_EDITMSG" },
    setup = [[vim.g.committia_min_window_width = 100]],
  }

  -- Git blame plugin for Neovim written in lua
  use {
    "f-person/git-blame.nvim",
    event = { "BufRead", "BufNewFile" },
    setup = [[vim.g.gitblame_enabled = 0]],
  }

  -- [[ Filetypes, Syntax ]]
  -- Nvim Treesitter configurations and abstraction layer
  use {
    "nvim-treesitter/nvim-treesitter",
    event = "BufRead *",
    run = ":TSUpdate",
    requires = {
      -- nvim-treesitter plugins
      { "nvim-treesitter/nvim-treesitter-refactor", opt = true },
      { "nvim-treesitter/nvim-treesitter-textobjects", opt = true },
      { "p00f/nvim-ts-rainbow", opt = true },
      { "JoosepAlviste/nvim-ts-context-commentstring", opt = true },
    },
    config = [[require("rc.config.treesitter").config()]],
  }

  -- A Neovim plugin to deal with treesitter unit
  use {
    "David-Kunz/treesitter-unit",
    requires = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      local keymap = require "rc.core.keymap"
      keymap.xnoremap { "iu", ":lua require('treesitter-unit').select()<CR>", silent = true }
      keymap.xnoremap { "au", ":lua require('treesitter-unit').select(true)<CR>", silent = true }
      keymap.onoremap { "iu", ":<C-u>lua require('treesitter-unit').select()<CR>", silent = true }
      keymap.onoremap { "au", ":<C-u>lua require('treesitter-unit').select(true)<CR>", silent = true }
    end,
  }

  -- Vim help in japanese
  use { "vim-jp/vimdoc-ja" }

  -- The luv docs in vimdoc format.
  use { "nanotee/luv-vimdocs" }

  -- GNU As
  use { "Shirk/vim-gas" }

  -- Python
  use { "vim-scripts/python_match.vim" }
  -- use { "raimon49/requirements.txt.vim" }
  use {
    "petobens/poet-v",
    ft = { "python" },
    setup = "vim.g.poetv_auto_activate = 1",
  }
  use { "tmhedberg/SimpylFold", ft = { "python" } }

  -- Lua
  use { "tjdevries/manillua.nvim" }

  -- Markdown
  use { "rhysd/vim-gfm-syntax", ft = { "markdown" } }
  use {
    "mattn/vim-maketable",
    ft = { "markdown" },
    cmd = { "MakeTable", "UnmakeTable" },
  }

  -- Zsh
  use { "chrisbra/vim-zsh" }

  -- Hex editor
  use {
    "Shougo/vinarise.vim",
    cmd = { "Vinarise" },
    setup = "vim.g.vinarise_enable_auto_detect = 1",
  }

  -- [[ Programming tools ]]

  -- EditorConfig
  use {
    "editorconfig/editorconfig-vim",
    event = "BufRead",
    setup = [[
    vim.g.EditorConfig_exclude_patterns = { "scp://.*", "term://.*", "gina://.*", "fugitive://.*" }
    ]],
  }

  -- Indent guides for Neovim
  use {
    "lukas-reineke/indent-blankline.nvim",
    requires = { "nvim-treesitter/nvim-treesitter" },
    event = { "FocusLost", "CursorHold" },
    config = [[require("rc.config.indent-blankline").config()]],
  }

  -- Comment plugin
  use {
    "numToStr/Comment.nvim",
    keys = { "gc", "gb", "gcc", "gbc" },
    requires = { "JoosepAlviste/nvim-ts-context-commentstring", opt = true },
    wants = { "nvim-ts-context-commentstring" },
    config = [[require("rc.config.comment").config()]],
  }

  -- A tree like view for symbols in Neovim using the Language Server Protocol.
  use {
    "simrat39/symbols-outline.nvim",
    module = { "symbols-outline" },
    cmd = { "SymbolsOutline", "SymbolsOutlineOpen", "SymbolsOutlineClose" },
    config = function()
      require("symbols-outline").setup {
        -- whether to highlight the currently hovered symbol disable if your
        -- cpu usage is higher than you want it or you just hate the highlight
        -- default: true
        highlight_hovered_item = true,

        -- whether to show outline guides
        -- default: true
        show_guides = true,
      }

      require("rc.core.keymap").nnoremap { "ms", "<cmd>SymbolsOutline<CR>", silent = true }
    end,
  }

  -- (DO)cument (GE)nerator
  -- use {
  --   "kkoomen/vim-doge",
  --   run = ":call doge#install()",
  --   ft = {
  --     "python",
  --     "php",
  --     "javascript",
  --     "typescript",
  --     "lua",
  --     "java",
  --     "groovy",
  --     "ruby",
  --     "cpp",
  --     "c",
  --     "bash",
  --     "rust",
  --   },
  --   -- setup = "require'conf.vim-doge'.setup()"
  --   setup = function()
  --     vim.g.doge_doc_standard_c = "doxygen_qt"
  --     vim.g.doge_doc_standard_cpp = "doxygen_qt"
  --     vim.g.doge_doc_standard_python = "numpy"
  --     -- Key mappings
  --     vim.g.doge_mapping = "<Leader>d"
  --     vim.g.doge_mapping_comment_jump_forward = "<M-n>"
  --     vim.g.doge_mapping_comment_jump_backward = "<M-p>"
  --   end,
  -- }

  -- Language Server Protocop (LSP)
  use {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre" },
    requires = {
      { "folke/lua-dev.nvim" },
      {
        "jose-elias-alvarez/null-ls.nvim",
        requires = {
          { "nvim-lua/plenary.nvim" },
          { "nvim-lua/popup.nvim" },
        },
      },
      {
        "simrat39/rust-tools.nvim",
        requires = {
          { "nvim-lua/plenary.nvim" },
          { "nvim-lua/popup.nvim" },
        },
      },
      -- {
      --   "folke/trouble.nvim",
      --   requires = { "kyazdani42/nvim-web-devicons" },
      -- },
      { "folke/which-key.nvim" },
    },
    wants = {
      "lua-dev.nvim",
      "null-ls.nvim",
      "rust-tools.nvim",
    },
    config = [[require "rc.config.lsp"]],
  }

  use {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    event = { "BufReadPre" },
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
    config = [[require("trouble").setup {}]],
  }

  -- Debug Adapter Protocol client implementation for Neovim
  use {
    "mfussenegger/nvim-dap",
    module = { "dap" },
    requires = {
      { "mfussenegger/nvim-dap-python", opt = true },
      { "theHamsta/nvim-dap-virtual-text", opt = true },
    },
    setup = [[require("rc.config.dap").setup()]],
    config = [[require("rc.config.dap").config()]],
  }

  use {
    "L3MON4D3/LuaSnip",
    module = { "luasnip" },
    requires = { "rafamadriz/friendly-snippets" },
    config = [[require("rc.config.luasnip").config()]],
  }

  use {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter *",
    requires = {
      { "hrsh7th/cmp-nvim-lsp", opt = true },
      { "hrsh7th/cmp-buffer", opt = true },
      { "hrsh7th/cmp-calc", opt = true },
      { "hrsh7th/cmp-cmdline", opt = true },
      { "hrsh7th/cmp-emoji", opt = true },
      { "hrsh7th/cmp-nvim-lua", opt = true },
      { "hrsh7th/cmp-path", opt = true },
      { "kdheepak/cmp-latex-symbols", opt = true },
      { "saadparwaiz1/cmp_luasnip", opt = true },
    },
    config = [[require("rc.config.nvim-cmp").config()]],
  }

  -- [[ Fuzzy finder ]]
  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      { "nvim-lua/popup.nvim" },
      { "nvim-lua/plenary.nvim" },
      { "kyazdani42/nvim-web-devicons" },
      { "nvim-telescope/telescope-cheat.nvim" },
      { "nvim-telescope/telescope-dap.nvim" },
      { "nvim-telescope/telescope-file-browser.nvim" },
      {
        "nvim-telescope/telescope-frecency.nvim",
        requires = { "tami5/sqlite.lua" },
        opt = true,
      },
      { "nvim-telescope/telescope-fzf-writer.nvim" },
      { "nvim-telescope/telescope-fzy-native.nvim" },
      { "nvim-telescope/telescope-hop.nvim" },
      { "nvim-telescope/telescope-packer.nvim" },
      {
        "nvim-telescope/telescope-smart-history.nvim",
        requires = { "tami5/sqlite.lua" },
        opt = true,
      },
      { "nvim-telescope/telescope-symbols.nvim" },
      { "nvim-telescope/telescope-ui-select.nvim" },
    },
    cmd = { "Telescope" },
    module = { "telescope" },
    setup = [[require("rc.config.telescope").setup()]],
    config = [[require("rc.config.telescope").config()]],
  }
end

return M
