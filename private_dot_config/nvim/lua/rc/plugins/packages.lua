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

  -- fix cursorhold performance
  -- todo: remove it if https://github.com/neovim/neovim/issues/12587 is fixed.
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
      require("nvim-web-devicons").setup { default = true }
    end,
  }

  -- A snazzy bufferline for Neovim
  use {
    "akinsho/nvim-bufferline.lua",
    requires = { "kyazdani42/nvim-web-devicons" },
    event = "BufReadPre",
    config = function()
      require("bufferline").setup { options = { always_show_bufferline = true } }
    end,
  }

  -- A fancy, configurable, notification manager for Neovim
  use {
    "rcarriga/nvim-notify",
    module = "notify",
  }

  -- Collection of minimal, independent, and fast Lua modules dedicated to improve Neovim experience.
  use {
    "echasnovski/mini.nvim",
    config = [[require("rc.config.mini").config()]],
  }

  -- Show keybindings in popup
  use {
    "folke/which-key.nvim",
    config = [[require("rc.config.which-key")]],
  }

  -- A high-performance color highlighter for NeoVim
  use {
    "norcalli/nvim-colorizer.lua",
    event = "BufReadPre",
    config = [[require("rc.config.colorizer")]],
  }

  -- [[ Editor ]]
  -- Enable repeating supported plugin maps with "."
  use { "tpope/vim-repeat" }

  -- Even better % navigation and highlight mathching words
  use { "andymass/vim-matchup", event = { "CursorHold" }, disable = true }

  -- Imporove foldtext for better looks
  use { "lambdalisue/readablefold.vim" }

  -- -- Better glance searched information
  -- use {
  --   "kevinhwang91/nvim-hlslens",
  --   module = { "hlslens" },
  --   setup = [[require("rc.config.hlslens").setup()]],
  --   config = [[require("rc.config.hlslens").config()]],
  -- }

  -- The extended search
  use {
    "hrsh7th/vim-searchx",
    fn = { "searchx#*" },
    setup = [[require("rc.config.vim-searchx").setup()]],
    config = [[require("rc.config.vim-searchx").config()]],
  }

  -- Enhanced f/t
  use {
    "hrsh7th/vim-eft",
    keys = {
      { "n", "<Plug>(eft-" },
      { "o", "<Plug>(eft-" },
      { "x", "<Plug>(eft-" },
    },
    setup = [[require("rc.config.vim-eft")]],
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
    setup = function()
      vim.g.niceblock_no_default_key_mappings = 1
      vim.keymap.set("v", "I", "<Plug>(niceblock-I)")
      vim.keymap.set("v", "gI", "<Plug>(niceblock-gI)")
      vim.keymap.set("v", "A", "<Plug>(niceblock-A)")
    end,
  }

  -- The killring-alike plugin with no default mappings.
  -- (Use this plugin until https://github.com/neovim/neovim/issues/1822 is fixed)
  use {
    "bfredl/nvim-miniyank",
    keys = { { "n", "<Plug>(miniyank-" } },
    setup = function()
      vim.g.miniyank_maxitems = 100
      vim.keymap.set("n", "p", "<Plug>(miniyank-autoput)")
      vim.keymap.set("n", "P", "<Plug>(miniyank-autoPut)")
    end,
  }

  -- Enhanced increment/decrement plugin for Neovim.
  use {
    "monaqa/dial.nvim",
    keys = {
      { "n", "<Plug>(dial-" },
      { "v", "<Plug>(dial-" },
    },
    setup = function()
      vim.keymap.set({ "n", "v" }, "<C-a>", "<Plug>(dial-increment)")
      vim.keymap.set({ "n", "v" }, "<C-x>", "<Plug>(dial-decrement)")
      vim.keymap.set("v", "g<C-a>", "<Plug>(dial-increment-additional)")
      vim.keymap.set("v", "g<C-x>", "<Plug>(dial-decrement-additional)")
    end,
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
      vim.keymap.set({ "n", "x" }, "_", "<Plug>(operator-replace)")
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
    setup = [[require("rc.config.vim-sandwich").setup()]],
    config = [[require("rc.config.vim-sandwich").config()]],
  }

  -- Smart align
  use {
    "junegunn/vim-easy-align",
    keys = {
      { "n", "<Plug>(EasyAlign)" },
      { "v", "<Plug>(EasyAlign)" },
    },
    setup = [[require("rc.config.vim-easy-align").setup()]],
    config = [[require("rc.config.vim-easy-align").config()]],
  }

  -- Better quickfix windowin Neovim, polish old quickfix window
  use { "kevinhwang91/nvim-bqf", branch = "main", ft = { "qf" } }

  -- Perform the replacement in quickfix
  use {
    "thinca/vim-qfreplace",
    ft = { "qf" },
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        group = "MyAutoCmd",
        pattern = { "qf" },
        callback = function()
          vim.keymap.set("n", "R", "<cmd>Qfreplace<CR>", { buffer = true })
        end,
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
      vim.keymap.set("n", "<Space>gl", "<Cmd>LazyGit<CR>", { silent = true })
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
      vim.keymap.set("n", "<Space>gm", "<Plug>(git-messenger)", { silent = true })
    end,
  }

  -- More pleasant editing on commit messsages
  use {
    "rhysd/committia.vim",
    ft = { "gitcommit" },
    setup = [[vim.g.committia_min_window_width = 100]],
  }

  -- A lua neovim plugin to generate shareable file permalinks (with line ranges) for several git web frontend hosts.
  -- Inspired by tpope/vim-fugitive's :GBrowse
  use {
    "ruifm/gitlinker.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    module = { "gitlinker" },
    setup = function()
      vim.keymap.set("n", "<Space>gy", "<Cmd>lua require'gitlinker'.get_buf_range_url('n')<CR>", { silent = true })
      vim.keymap.set("v", "<Space>gy", "<Cmd>lua require'gitlinker'.get_buf_range_url('n')<CR>")
      vim.keymap.set("n", "<Space>gY", "<Cmd>lua require'gitlinker'.get_repo_url()<CR>")
      vim.keymap.set(
        "n",
        "<Space>gB",
        "<Cmd>lua require'gitlinker'.get_repo_url({action_callback = require'gitlinker.actions'.open_in_browser})<CR>"
      )
    end,
    config = function()
      require("gitlinker").setup {
        mappings = nil,
      }
    end,
  }

  -- [[ Filetypes, Syntax ]]
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
    setup = function()
      vim.g.vinarise_enable_auto_detect = 1
    end,
  }

  -- [[ Programming tools ]]

  -- EditorConfig
  use {
    "editorconfig/editorconfig-vim",
    event = "BufRead",
    setup = function()
      vim.g.EditorConfig_exclude_patterns = {
        "scp://.*",
        "term://.*",
        "gina://.*",
        "fugitive://.*",
      }
    end,
  }

  -- Indent guides for Neovim
  use {
    "lukas-reineke/indent-blankline.nvim",
    -- requires = { "nvim-treesitter/nvim-treesitter" },
    after = { "nvim-treesitter" },
    event = { "FocusLost", "CursorHold" },
    config = [[require("rc.config.indent_blankline").config()]],
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
      vim.keymap.set("n", "ms", "<Cmd>SymbolsOutline<CR>", { silent = true })
    end,
  }

  -- [[ Treesitter ]]
  -- Nvim Treesitter configurations and abstraction layer
  use {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufNewFile", "BufRead" },
    run = ":TSUpdate",
    requires = {
      -- nvim-treesitter plugins
      { "nvim-treesitter/nvim-treesitter-refactor", opt = true },
      { "nvim-treesitter/nvim-treesitter-textobjects", opt = true },
      { "nvim-treesitter/playground", opt = true },
      { "p00f/nvim-ts-rainbow", opt = true },
      { "JoosepAlviste/nvim-ts-context-commentstring", opt = true },
      { "David-Kunz/treesitter-unit", opt = true },
    },
    wants = {
      "nvim-treesitter-refactor",
      "nvim-treesitter-textobjects",
      "playground",
      "nvim-ts-rainbow",
      "nvim-ts-context-commentstring",
      "treesitter-unit",
    },
    config = [[require("rc.config.treesitter").config()]],
  }

  -- [[ Language Server Protocop (LSP) ]]
  use {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre" },
    requires = {
      {
        "williamboman/nvim-lsp-installer",
        branch = "main",
        module = "nvim-lsp-installer",
        cmd = {
          "LspInstall",
          "LspInstallInfo",
          "LspUninstall",
          "LspUninstallAll",
          "LspInstallLog",
          "LspPrintInstalled",
        },
      },
      {
        "jose-elias-alvarez/null-ls.nvim",
        requires = {
          { "nvim-lua/plenary.nvim" },
          { "nvim-lua/popup.nvim" },
        },
      },
      {
        "simrat39/rust-tools.nvim",
        module = { "rust-tools" },
        requires = {
          { "nvim-lua/plenary.nvim" },
          { "nvim-lua/popup.nvim" },
        },
      },
      { "p00f/clangd_extensions.nvim" },
      { "folke/which-key.nvim" },
    },
    wants = {
      "clangd_extensions.nvim",
      "null-ls.nvim",
      "nvim-lsp-installer",
      "rust-tools.nvim",
    },
    config = [[require("rc.config.lsp")]],
  }

  use {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    event = { "BufReadPre" },
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
    config = [[require("trouble").setup {}]],
  }

  -- Standalone UI for nvim-lsp progress. Eye candy for the impatient.
  use {
    "j-hui/fidget.nvim",
    config = [[require("fidget").setup {}]],
  }

  -- [[ Debug Adaptor Protocol (DAP) ]]
  -- Debug Adapter Protocol client implementation for Neovim
  use {
    "mfussenegger/nvim-dap",
    module = { "dap" },
    requires = {
      { "mfussenegger/nvim-dap-python" },
      { "theHamsta/nvim-dap-virtual-text" },
    },
    setup = [[require("rc.config.dap").setup()]],
    config = [[require("rc.config.dap").config()]],
  }

  -- [[ Completion ]]
  use {
    "L3MON4D3/LuaSnip",
    module = { "luasnip" },
    requires = { "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip").config.set_config {
        history = true,
        updateevents = "TextChanged,TextChangedI",
      }
      -- register snippets directories
      local path = require "rc.core.path"
      require("luasnip.loaders.from_vscode").load {
        paths = {
          -- REMARK: package.json files are required in the following directories
          -- path.join(path.config_home, "snippets"),
          path.join(path.pack_root, "packer", "start", "friendly-snippets"),
        },
      }
    end,
  }

  use {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter" },
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
  -- Find, Filter, Preview, Pick. All lua, all the time.
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
