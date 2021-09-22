local M = {}

function M.load_plugins(use, _)
  -- [[ Fundamental plugins ]]
  -- A use-package inspired plugin manager for Neovim.
  -- (Packer can manage itself as an optional plugin)
  use { "wbthomason/packer.nvim", opt = true }

  use { "lewis6991/impatient.nvim" }

  -- plenary: full; complete; entire; absolute; unqualified.
  use { "nvim-lua/plenary.nvim" }

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
    setup = [[require("config.tmux").setup()]],
    config = [[require("config.tmux").config()]],
  }

  -- [[ UI ]]
  -- Colorschemes
  use { "EdenEast/nightfox.nvim", opt = true }
  use { "folke/tokyonight.nvim", opt = true }
  use { "sainnhe/edge", opt = true }
  use { "sainnhe/everforest", opt = true }
  use { "sainnhe/sonokai", opt = true }
  use { "shaunsingh/moonlight.nvim", opt = true }
  use { "shaunsingh/nord.nvim", opt = true }

  -- A blazing fast and easy to configure neovim statusline plugin written in pure lua.
  use {
    "hoob3rt/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
    config = [[require('config.lualine').config()]],
  }

  -- A snazzy bufferline for Neovim
  use {
    "akinsho/nvim-bufferline.lua",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
    event = "BufReadPre",
    config = function()
      require("bufferline").setup {
        options = { always_show_bufferline = true },
      }
    end,
  }

  -- Better whitespace highlighting
  use {
    "ntpeters/vim-better-whitespace",
    event = { "BufNewFile", "BufRead" },
    setup = [[require("config.vim-better-whitespace").setup()]],
  }

  -- A file explorer tree for neovim written in lua
  use {
    "kyazdani42/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeRefresh", "NvimTreeFindFile" },
    setup = [[require("config.nvim-tree").setup()]],
    config = [[require("config.nvim-tree").config()]],
  }

  -- [[ Editor ]]
  -- Enable repeating supported plugin maps with "."
  use { "tpope/vim-repeat" }

  -- Even better % navigation and highlight mathching words
  use { "andymass/vim-matchup", event = { "CursorHold" } }

  -- Imporove foldtext for better looks
  use { "lambdalisue/readablefold.vim" }

  -- Better glance searched information
  use {
    "kevinhwang91/nvim-hlslens",
    module = { "hlslens" },
    setup = function()
      vim.keymap.nnoremap {
        "n",
        "<cmd>execute('normal! ' . v:count1 . 'n')<CR><cmd>lua require'hlslens'.start()<CR>",
        silent = true,
      }
      vim.keymap.nnoremap {
        "N",
        "<cmd>execute('normal! ' . v:count1 . 'N')<CR><cmd>lua require'hlslens'.start()<CR>",
        silent = true,
      }
      vim.keymap.nnoremap { "*", "*<cmd>lua require'hlslens'.start()<CR>", silent = true }
      vim.keymap.nnoremap { "#", "#<cmd>lua require'hlslens'.start()<CR>", silent = true }
      vim.keymap.nnoremap { "g*", "g*<cmd>lua require'hlslens'.start()<CR>", silent = true }
      vim.keymap.nnoremap { "g#", "g#<cmd>lua require'hlslens'.start()<CR>", silent = true }
    end,
    config = function()
      require("hlslens").setup {
        auto_enable = true,
        calm_down = true,
      }
    end,
  }

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
    setup = function()
      vim.keymap.nmap { "f", "<Plug>(eft-f-repeatable)" }
      vim.keymap.xmap { "f", "<Plug>(eft-f-repeatable)" }
      vim.keymap.omap { "f", "<Plug>(eft-f-repeatable)" }
      vim.keymap.nmap { "F", "<Plug>(eft-F-repeatable)" }
      vim.keymap.xmap { "F", "<Plug>(eft-F-repeatable)" }
      vim.keymap.omap { "F", "<Plug>(eft-F-repeatable)" }
      vim.keymap.nmap { "t", "<Plug>(eft-t-repeatable)" }
      vim.keymap.xmap { "t", "<Plug>(eft-t-repeatable)" }
      vim.keymap.omap { "t", "<Plug>(eft-t-repeatable)" }
      vim.keymap.nmap { "T", "<Plug>(eft-T-repeatable)" }
      vim.keymap.xmap { "T", "<Plug>(eft-T-repeatable)" }
      vim.keymap.omap { "T", "<Plug>(eft-T-repeatable)" }
    end,
  }

  -- Neovim motions on speed!
  use {
    "phaazon/hop.nvim",
    module = { "hop" },
    setup = function()
      vim.keymap.nnoremap { "ss", "<cmd>lua require'hop'.hint_char2()<CR>" }
      vim.keymap.xnoremap { "ss", "<cmd>lua require'hop'.hint_char2()<CR>" }
      vim.keymap.onoremap { "ss", "<cmd>lua require'hop'.hint_char2()<CR>" }

      vim.keymap.nnoremap { "sl", "<cmd>lua require'hop'.hint_lines()<CR>" }
      vim.keymap.xnoremap { "sl", "<cmd>lua require'hop'.hint_lines()<CR>" }
      vim.keymap.onoremap { "sl", "<cmd>lua require'hop'.hint_lines()<CR>" }

      vim.keymap.nnoremap { "s/", "<cmd>lua require'hop'.hint_patterns()<CR>" }
      vim.keymap.xnoremap { "s/", "<cmd>lua require'hop'.hint_patterns()<CR>" }
      vim.keymap.onoremap { "s/", "<cmd>lua require'hop'.hint_patterns()<CR>" }
    end,
  }

  -- Make blockwise visual mode more useful
  use {
    "kana/vim-niceblock",
    keys = { { "v", "<Plug>(niceblock-" } },
    setup = function()
      vim.g.niceblock_no_default_key_mappings = 1
      vim.keymap.vmap { "I", "<Plug>(niceblock-I)" }
      vim.keymap.vmap { "gI", "<Plug>(niceblock-gI)" }
      vim.keymap.vmap { "A", "<Plug>(niceblock-A)" }
    end,
  }

  -- Smart line join
  use {
    "osyo-manga/vim-jplus",
    keys = {
      { "n", "<Plug>(jplus)" },
      { "v", "<Plug>(jplus)" },
      { "n", "<Plug>(jplus-input)" },
      { "v", "<Plug>(jplus-input)" },
    },
    setup = function()
      vim.keymap.nmap { "J", "<Plug>(jplus)" }
      vim.keymap.vmap { "J", "<Plug>(jplus)" }
      vim.keymap.nmap { "<Leader>J", "<Plug>(jplus-input)" }
      vim.keymap.vmap { "<Leader>J", "<Plug>(jplus-input)" }
    end,
  }

  -- The killring-alike plugin with no default mappings.
  -- (Use this plugin until https://github.com/neovim/neovim/issues/1822 is fixed)
  use {
    "bfredl/nvim-miniyank",
    keys = { { "n", "<Plug>(miniyank-" } },
    setup = function()
      vim.g.miniyank_maxitems = 100
      vim.keymap.nmap { "p", "<Plug>(miniyank-autoput)" }
      vim.keymap.nmap { "P", "<Plug>(miniyank-autoPut)" }
    end,
  }

  -- Enhanced increment/decrement plugin for Neovim.
  use {
    "monaqa/dial.nvim",
    keys = { { "n", "<Plug>(dial-" }, { "v", "<Plug>(dial-" } },
    setup = function()
      vim.keymap.nmap { "<C-a>", "<Plug>(dial-increment)" }
      vim.keymap.nmap { "<C-x>", "<Plug>(dial-decrement)" }
      vim.keymap.vmap { "<C-a>", "<Plug>(dial-increment)" }
      vim.keymap.vmap { "<C-x>", "<Plug>(dial-decrement)" }
      vim.keymap.vmap { "g<C-a>", "<Plug>(dial-increment-additional)" }
      vim.keymap.vmap { "g<C-x>", "<Plug>(dial-decrement-additional)" }
    end,
  }

  -- A more adventurous wildmenu

  -- Show keybindings in popup
  use {
    "folke/which-key.nvim",
    config = [[require("config.which-key").config()]],
  }

  -- A high-performance color highlighter for NeoVim
  use {
    "norcalli/nvim-colorizer.lua",
    event = "BufReadPre",
    cmd = {
      "ColorizerAttachToBuffer",
      "ColorizerDetachFromBuffer",
      "ColorizerReloadAllBuffers",
      "ColorizerToggle",
    },
    config = function()
      require("colorizer").setup()
    end,
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
      vim.keymap.nmap { "_", "<Plug>(operator-replace)" }
      vim.keymap.xmap { "_", "<Plug>(operator-replace)" }
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
    setup = [[require("config.sandwich").setup()]],
    config = [[require("config.sandwich").config()]],
  }

  -- Smart align
  use {
    "junegunn/vim-easy-align",
    keys = { { "n", "<Plug>(EasyAlign)" }, { "v", "<Plug>(EasyAlign)" } },
    setup = require("config.vim-easy-align").setup,
  }

  -- SKK input method for Japanese
  use {
    "tyru/eskk.vim",
    event = "InsertCharPre",
    config = require("config.eskk").config,
  }

  -- Better quickfix windowin Neovim, polish old quickfix window
  use { "kevinhwang91/nvim-bqf", branch = "main", ft = { "qf" } }

  -- Perform the replacement in quickfix
  use {
    "thinca/vim-qfreplace",
    ft = { "qf" },
    config = function()
      require("utils.autocmd").group("MyAutoCmd", {
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
      vim.keymap.nnoremap { "<Space>gl", "<cmd>LazyGit<CR>", silent = true }
    end,
  }

  -- Git signs written in pure lua
  use {
    "lewis6991/gitsigns.nvim",
    branch = "main",
    event = { "FocusLost", "CursorHold" },
    requires = { "nvim-lua/plenary.nvim" },
    config = [[require("config.gitsigns").config()]],
  }

  -- Reveal the commit messages under the cursor
  use {
    "rhysd/git-messenger.vim",
    cmd = { "GitMessenger" },
    keys = { { "n", "<Plug>(git-messenger" } },
    setup = function()
      vim.g.git_messenger_no_default_mappings = true
      vim.keymap.nmap { "<Space>gm", "<Plug>(git-messenger)", silent = true }
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
    config = [[require("config.treesitter").config()]],
  }

  -- A Neovim plugin to deal with treesitter unit
  use {
    "David-Kunz/treesitter-unit",
    requires = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      vim.keymap.xnoremap { "iu", ":lua require('treesitter-unit').select()<CR>", silent = true }
      vim.keymap.xnoremap { "au", ":lua require('treesitter-unit').select(true)<CR>", silent = true }
      vim.keymap.onoremap { "iu", ":<C-u>lua require('treesitter-unit').select()<CR>", silent = true }
      vim.keymap.onoremap { "au", ":<C-u>lua require('treesitter-unit').select(true)<CR>", silent = true }
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
    requires = { "nvim-treesitter/nvim-treesitter" },
    event = { "FocusLost", "CursorHold" },
    config = function()
      require("indent_blankline").setup {
        char = "│",
        buftype_exclude = { "prompt", "terminal" },
        filetype_exclude = { "help", "packer" },
        use_treesitter = true,
        show_first_indent_level = false,
        show_current_context = true,
        show_end_of_line = true,
      }
    end,
  }

  -- Comment plugin
  use {
    "terrortylor/nvim-comment",
    config = function()
      require("nvim_comment").setup {
        -- Linters prefer comment and line to have a space in between markers
        marker_padding = true,
        -- should comment out empty or whitespace only lines
        comment_empty = false,
        -- Should key mappings be created
        create_mappings = true,
        -- Normal mode mapping left hand side
        line_mapping = "gcc",
        -- Visual/Operator mapping left hand side
        operator_mapping = "gc",
      }
    end,
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

      vim.keymap.nnoremap { "ms", "<cmd>SymbolsOutline<CR>", silent = true }
    end,
  }

  -- (DO)cument (GE)nerator
  use {
    "kkoomen/vim-doge",
    run = ":call doge#install()",
    ft = {
      "python",
      "php",
      "javascript",
      "typescript",
      "lua",
      "java",
      "groovy",
      "ruby",
      "cpp",
      "c",
      "bash",
      "rust",
    },
    -- setup = "require'conf.vim-doge'.setup()"
    setup = function()
      vim.g.doge_doc_standard_c = "doxygen_qt"
      vim.g.doge_doc_standard_cpp = "doxygen_qt"
      vim.g.doge_doc_standard_python = "numpy"
      -- Key mappings
      vim.g.doge_mapping = "<Leader>d"
      vim.g.doge_mapping_comment_jump_forward = "<M-n>"
      vim.g.doge_mapping_comment_jump_backward = "<M-p>"
    end,
  }

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
        opt = true,
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
    config = [[require "config.lspconfig"]],
  }

  use {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    event = { "BufReadPre" },
    requires = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require("trouble").setup {}
    end,
  }

  -- Debug Adapter Protocol client implementation for Neovim
  use {
    "mfussenegger/nvim-dap",
    module = { "dap" },
    requires = {
      { "mfussenegger/nvim-dap-python", opt = true },
      { "theHamsta/nvim-dap-virtual-text", opt = true },
    },
    setup = [[require("config.dap").setup()]],
    config = [[require("config.dap").config()]],
  }

  -- [[ Auto completions ]]
  -- use {
  --   "hrsh7th/vim-vsnip",
  --   event = "InsertEnter *",
  --   requires = {
  --     "rafamadriz/friendly-snippets",
  --   },
  --   setup = function()
  --     require("config.vim-vsnip").setup()
  --   end,
  --   config = function()
  --     require("config.vim-vsnip").config()
  --   end,
  -- }

  use {
    "L3MON4D3/LuaSnip",
    module = { "luasnip" },
    requires = { "rafamadriz/friendly-snippets" },
    config = [[require("config.luasnip").config()]],
  }

  use {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter *",
    requires = {
      { "hrsh7th/cmp-nvim-lsp", opt = true },
      { "hrsh7th/cmp-buffer", opt = true },
      { "hrsh7th/cmp-calc", opt = true },
      { "hrsh7th/cmp-emoji", opt = true },
      { "hrsh7th/cmp-nvim-lua", opt = true },
      { "hrsh7th/cmp-path", opt = true },
      { "kdheepak/cmp-latex-symbols", opt = true },
      { "saadparwaiz1/cmp_luasnip", opt = true },
    },
    config = [[require("config.nvim-cmp").config()]],
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
      {
        "nvim-telescope/telescope-frecency.nvim",
        requires = { "tami5/sqlite.lua" },
        opt = true,
      },
      { "nvim-telescope/telescope-fzf-writer.nvim" },
      { "nvim-telescope/telescope-fzy-native.nvim" },
      { "nvim-telescope/telescope-ghq.nvim" },
      { "nvim-telescope/telescope-packer.nvim" },
      { "nvim-telescope/telescope-symbols.nvim" },
      { "nvim-telescope/telescope-symbols.nvim" },
    },
    cmd = { "Telescope" },
    module = { "telescope" },
    setup = [[require("config.telescope").setup()]],
    config = [[require("config.telescope").config()]],
  }
end

return M
