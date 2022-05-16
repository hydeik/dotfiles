local M = {}

function M.load_plugins(use, _)
  --- [[ Plugin manager ]]
  -- A use-package inspired plugin manager for Neovim.
  -- (Packer can manage itself as an optional plugin)
  use { "wbthomason/packer.nvim", opt = true }

  --- [[ Libraries that are required by other plugins ]]
  --- [Lua libraries]

  -- Speed up loading Lua modules in Neovim to improve startup time.
  use { "lewis6991/impatient.nvim" }

  -- plenary: full; complete; entire; absolute; unqualified.
  use { "nvim-lua/plenary.nvim" }

  -- SQLite/LuaJIT binding for lua and neovim
  use { "tami5/sqlite.lua" }

  -- An implementation of the popup API from vim in Neovim. Hope to upstream when complete.
  use { "nvim-lua/popup.nvim" }

  -- UI completion library for Neovim
  use { "MunifTanjim/nui.nvim" }

  -- A fancy, configurable, notification manager for Neovim
  use { "rcarriga/nvim-notify" }

  -- Icons
  use { "kyazdani42/nvim-web-devicons" }

  --- [Vim script libraries]

  -- fix cursorhold performance
  -- todo: remove it if https://github.com/neovim/neovim/issues/12587 is fixed.
  use {
    "antoinemadec/FixCursorHold.nvim",
    config = [[vim.g.cursorhold_updatetime = 100]],
  }

  -- Original popup completion menu framework library
  use { "Shougo/pum.vim" }

  -- repeat.vim: enable repeatable supported plugin maps with "."
  use { "tpope/vim-repeat" }

  --- [[ Completion ]]
  -- Snippet Engine for Neovim written in Lua.
  use {
    "L3MON4D3/LuaSnip",
    module = { "luasnip" },
    event = { "InsertEnter" },
    requires = { "rafamadriz/friendly-snippets" },
    config = [[require("rc.config.luasnip").config()]],
  }

  -- A super powerful autopair plugin for Neovim that supports multiple characters.
  use {
    "windwp/nvim-autopairs",
    module = { "nvim-autopairs" },
    event = { "InsertEnter" },
    config = [[require("rc.config.nvim-autopairs").config()]],
  }

  -- A super powerful autopair plugin for Neovim that supports multiple characters.
  use {
    "windwp/nvim-ts-autotag",
    after = { "nvim-treesitter" },
    event = { "InsertEnter" },
    config = [[require("nvim-ts-autotag").setup()]],
  }

  -- A completion plugin for neovim coded in Lua.
  use {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter" },
    after = { "LuaSnip", "nvim-autopairs" },
    requires = {
      { "L3MON4D3/LuaSnip", opt = true },
      { "windwp/nvim-autopairs", opt = true },
    },
    config = [[require("rc.config.nvim-cmp")]],
  }

  -- nvim-cmp sources
  use { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" }
  use { "hrsh7th/cmp-nvim-lsp-document-symbol", after = "nvim-cmp" }
  use { "hrsh7th/cmp-nvim-lsp-signature-help", after = "nvim-cmp" }
  use { "hrsh7th/cmp-buffer", after = "nvim-cmp" }
  use { "hrsh7th/cmp-calc", after = "nvim-cmp" }
  use { "hrsh7th/cmp-cmdline", after = "nvim-cmp" }
  use { "hrsh7th/cmp-emoji", after = "nvim-cmp" }
  use { "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" }
  use { "hrsh7th/cmp-path", after = "nvim-cmp" }
  use { "kdheepak/cmp-latex-symbols", after = "nvim-cmp" }
  use { "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" }
  use { "ray-x/cmp-treesitter", after = "nvim-cmp" }

  --- [[ Fuzzy finder ]]
  -- Find, Filter, Preview, Pick. All lua, all the time.
  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      { "nvim-lua/popup.nvim" },
      { "nvim-lua/plenary.nvim" },
      { "kyazdani42/nvim-web-devicons" },
    },
    cmd = { "Telescope" },
    module = { "telescope" },
    setup = [[require("rc.config.telescope").setup()]],
    config = [[require("rc.config.telescope").config()]],
  }

  -- Telescope's extensions
  use {
    "nvim-telescope/telescope-cheat.nvim",
    after = "telescope.nvim",
    config = [[require("telescope").load_extension("cheat")]],
  }

  use {
    "nvim-telescope/telescope-dap.nvim",
    after = "telescope.nvim",
    config = [[require("telescope").load_extension("dap")]],
  }

  use {
    "LinArcX/telescope-env.nvim",
    after = "telescope.nvim",
    config = [[require("telescope").load_extension("env")]],
  }

  use {
    "nvim-telescope/telescope-file-browser.nvim",
    after = "telescope.nvim",
    config = [[require("telescope").load_extension("file_browser")]],
  }

  use {
    "nvim-telescope/telescope-frecency.nvim",
    requires = { "tami5/sqlite.lua" },
    after = "telescope.nvim",
    config = [[require("telescope").load_extension("frecency")]],
  }

  use {
    "nvim-telescope/telescope-fzf-writer.nvim",
    after = "telescope.nvim",
    config = [[require("telescope").load_extension("fzf_writer")]],
  }

  use {
    "nvim-telescope/telescope-fzy-native.nvim",
    after = "telescope.nvim",
    config = [[require("telescope").load_extension("fzy_native")]],
  }

  use { "nvim-telescope/telescope-hop.nvim" }

  use {
    "nvim-telescope/telescope-packer.nvim",
    after = "telescope.nvim",
    config = [[require("telescope").load_extension("packer")]],
  }

  use {
    "nvim-telescope/telescope-smart-history.nvim",
    requires = { "tami5/sqlite.lua" },
    after = "telescope.nvim",
    config = [[require("telescope").load_extension("smart_history")]],
  }

  use {
    "nvim-telescope/telescope-symbols.nvim",
    after = "telescope.nvim",
  }

  use {
    "nvim-telescope/telescope-ui-select.nvim",
    after = "telescope.nvim",
    config = [[require("telescope").load_extension("ui-select")]],
  }

  --- [[ Treesitter ]]
  -- Nvim Treesitter configurations and abstraction layer
  use {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufNewFile", "BufRead" },
    run = ":TSUpdate",
    config = [[require("rc.config.treesitter")]],
  }

  -- [ Treesitter's extensions ]
  use {
    "nvim-treesitter/nvim-treesitter-refactor",
    after = "nvim-treesitter",
  }

  use {
    "nvim-treesitter/nvim-treesitter-textobjects",
    after = "nvim-treesitter",
  }

  use {
    "nvim-treesitter/playground",
    after = "nvim-treesitter",
  }

  use {
    "p00f/nvim-ts-rainbow",
    after = "nvim-treesitter",
  }

  use {
    "JoosepAlviste/nvim-ts-context-commentstring",
    after = "nvim-treesitter",
  }

  use {
    "yioneko/nvim-yati",
    after = "nvim-treesitter",
  }

  --- [ Plugins powered by treesitter ]
  -- Interactively select and swap function arguments, list elements, and more. Powered by tree-sitter.
  use {
    "mizlan/iswap.nvim",
    after = "nvim-treesitter",
    config = [[require("rc.config.iswap").config()]],
  }

  use {
    "David-Kunz/treesitter-unit",
    after = "nvim-treesitter",
  }

  -- Virtual text context for neovim treesitter
  use {
    "haringsrob/nvim_context_vt",
    after = "nvim-treesitter",
  }

  --- [[ UI ]]

  --- [ Colorschemes ]
  local colorscheme = "nightfox.nvim"
  use { "EdenEast/nightfox.nvim", config = [[require("rc.config.nightfox")]] }

  --- [ Statusline/Tabline/Bufferline ]

  -- A snazzy bufferline for Neovim
  use {
    "akinsho/nvim-bufferline.lua",
    requires = { "kyazdani42/nvim-web-devicons" },
    event = { "BufReadPre" },
    config = [[require("bufferline").setup { options = { always_show_bufferline = true } }]],
  }

  --- [ Scroll bar ]
  -- Extensible Neovim Scrollbar
  use {
    "petertriho/nvim-scrollbar",
    -- requires = { "kevinhwang91/nvim-hlslens", opt = true },
    requires = { "nvim-hlslens" },
    event = { "VimEnter" },
    after = { colorscheme },
    config = [[require("rc.config.nvim-scrollbar")]],
  }

  --- [ Highlight ]

  -- Collection of minimal, independent, and fast Lua modules dedicated to improve Neovim experience.
  -- Currently, only the mini.tailspace module is used.
  use {
    "echasnovski/mini.nvim",
    event = { "BufReadPost" },
    config = [[require("rc.config.mini").config()]],
  }

  -- A high-performance color highlighter for NeoVim
  use {
    "norcalli/nvim-colorizer.lua",
    event = { "BufReadPost" },
    config = [[require("rc.config.colorizer").config()]],
  }

  -- Highlight, list and search todo comments in your project
  use {
    "folke/todo-comments.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    cmd = { "TodoQuickFix", "TodoLocList", "TodoTelescope", "TodoTrouble" },
    event = { "BufReadPost" },
    config = [[require("rc.config.todo-comments").config()]],
  }

  -- Prismatic line decorations for the adventurous vim user
  use {
    "mvllow/modes.nvim",
    event = { "BufReadPost" },
    config = [[require("modes").setup()]],
  }

  -- Show keybindings in popup
  use {
    "folke/which-key.nvim",
    config = [[require("rc.config.which-key")]],
    disable = true,
  }

  --- [[ Motion ]]

  -- tmux integration for nvim features pane movement and resizing from within nvim.
  use {
    "aserowy/tmux.nvim",
    module = { "tmux" },
    setup = [[require("rc.config.tmux").setup()]],
    config = [[require("rc.config.tmux").config()]],
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

  -- More useful word motions for Vim (CamelCase, sneak_case, etc.)
  use {
    "chaoren/vim-wordmotion",
    keys = {
      { "n", "<Plug>WordMotion_" },
      { "x", "<Plug>WordMotion_" },
      { "o", "<Plug>WordMotion_" },
      { "c", "<Plug>WordMotion_" },
    },
    setup = [[require("rc.config.vim-wordmotion").setup()]],
  }
  -- [[ Editor ]]

  -- [ Selection ]
  -- Make blockwise visual mode more useful
  use {
    "kana/vim-niceblock",
    keys = { { "v", "<Plug>(niceblock-" } },
    setup = [[require("rc.config.vim-niceblock").setup()]],
  }

  -- [ Align ]
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

  -- [ Textobject & Operator ]
  use { "kana/vim-textobj-user" }

  use { "kana/vim-operator-user" }

  -- a Vim plugin to provide some operators to convert a word case.
  use {
    "mopp/vim-operator-convert-case",
    requires = {
      { "kana/vim-operator-user" },
      { "tpope/vim-repeat" },
    },
    cmd = { "ConvertCaseToggleUpperLower", "ConvertCaseLoop", "ConvertCase" },
    keys = {
      { "n", "<Plug>(operator-convert-case-" },
      { "x", "<Plug>(operator-convert-case-" },
    },
    setup = [[require("rc.config.vim-operator-convert-case").setup()]],
  }

  -- Neovim plugin introducing a new operators motions to quickly replace and exchange text.
  use {
    "gbprod/substitute.nvim",
  }
  -- Set of operators and textobjects to search/select/edit sandwiched texts.
  use {
    "machakann/vim-sandwich",
    event = { "CursorHold" },
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

  -- [ Handling numbers ]
  -- vim plugin for sequencial numbering with pattern
  use {
    "deris/vim-rengbang",
    cmd = { "RengBang", "RengBangConfirm" },
  }

  -- Enhanced increment/decrement plugin for Neovim.
  use {
    "monaqa/dial.nvim",
    keys = {
      { "n", "<Plug>(dial-" },
      { "v", "<Plug>(dial-" },
    },
    setup = [[require("rc.config.dial").setup()]],
  }

  -- [ Yank & Paste ]

  -- Preview the content of the registers
  use {
    "tversteeg/registers.nvim",
    branch = "main",
    keys = {
      { "n", '"' },
      { "i", "<C-r>" },
    },
  }

  -- [ Search ]
  -- Imporove foldtext for better looks
  use { "lambdalisue/readablefold.vim" }

  -- Better glance searched information
  use {
    "kevinhwang91/nvim-hlslens",
    module = { "hlslens" },
    setup = [[require("rc.config.hlslens").setup()]],
    config = [[require("rc.config.hlslens").config()]],
  }

  -- -- The extended search
  -- use {
  --   "hrsh7th/vim-searchx",
  --   fn = { "searchx#*" },
  --   setup = [[require("rc.config.vim-searchx").setup()]],
  --   config = [[require("rc.config.vim-searchx").config()]],
  -- }

  -- Breakdown Vim's --startuptime output
  use { "tweekmonster/startuptime.vim", cmd = "StartupTime" }

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
    setup = [[require("rc.config.lazygit").setup()]],
  }

  -- Git signs written in pure lua
  use {
    "lewis6991/gitsigns.nvim",
    branch = "main",
    event = { "FocusLost", "CursorHold" },
    requires = { "nvim-lua/plenary.nvim" },
    config = [[require("rc.config.gitsigns")]],
  }

  -- Reveal the commit messages under the cursor
  use {
    "rhysd/git-messenger.vim",
    cmd = { "GitMessenger" },
    keys = { { "n", "<Plug>(git-messenger" } },
    setup = [[require("rc.config.git-messenger").setup()]],
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
    setup = [[require("rc.config.gitlinker").setup()]],
    config = [[require("rc.config.gitlinker").config()]],
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
    setup = [[vim.g.vinarise_enable_auto_detect = 1]],
  }

  -- [[ Programming tools ]]

  -- EditorConfig
  use {
    "editorconfig/editorconfig-vim",
    event = { "BufNewFile", "BufRead" },
  }

  -- Indent guides for Neovim
  use {
    "lukas-reineke/indent-blankline.nvim",
    requires = { "nvim-treesitter/nvim-treesitter" },
    event = { "FocusLost", "CursorHold" },
    config = [[require("rc.config.indent_blankline")]],
  }

  -- Comment plugin
  use {
    "numToStr/Comment.nvim",
    keys = { "gc", "gb", "gcc", "gbc" },
    requires = { "JoosepAlviste/nvim-ts-context-commentstring" },
    config = [[require("rc.config.Comment")]],
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

  -- [[ Language Server Protocop (LSP) ]]
  use {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre" },
    requires = {
      {
        "williamboman/nvim-lsp-installer",
        branch = "main",
        module = { "nvim-lsp-installer" },
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
end

return M
