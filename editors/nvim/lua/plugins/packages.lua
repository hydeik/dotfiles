local M = {}

function M.load_plugins(use, _)
  -- [[ Fundamental plugins ]]
  -- Packer can manage itself as an optional plugin
  use { "wbthomason/packer.nvim", opt = true }

  use { "nvim-lua/plenary.nvim" }

  -- Fix CursorHold performance
  -- TODO: remove it if https://github.com/neovim/neovim/issues/12587 is fixed.
  use {
    "antoinemadec/FixCursorHold.nvim",
    config = [[vim.g.cursorhold_updatetime = 100]],
  }

  -- Smoothly navigate between splits and panes
  use {
    "numToStr/Navigator.nvim",
    config = require("plugins.config.navigator").config,
  }

  -- [[ UI ]]
  -- Colorschemes
  use { "sainnhe/edge", opt = true }
  use { "sainnhe/sonokai", opt = true }

  -- A snazzy bufferline for Neovim
  use {
    "akinsho/nvim-bufferline.lua",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
    event = "VimEnter",
    config = function()
      require("bufferline").setup {
        options = { mappings = true, always_show_bufferline = true },
      }
    end,
  }

  -- Better whitespace highlighting
  use {
    "ntpeters/vim-better-whitespace",
    event = { "BufNewFile *", "BufRead *" },
    setup = require("plugins.config.vim-better-whitespace").setup,
  }

  -- A file explorer tree for neovim written in lua
  use {
    "kyazdani42/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeRefresh", "NvimTreeFindFile" },
    setup = require("plugins.config.nvim-tree").setup,
    config = require("plugins.config.nvim-tree").config,
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
    config = function()
      local opts = { silent = true, noremap = true }
      vim.api.nvim_set_keymap(
        "n", "n",
        "<cmd>execute('normal! ' . v:count1 . 'n')<CR><cmd>lua require'hlslens'.start()<CR>",
        opts
      )
      vim.api.nvim_set_keymap(
        "n", "N",
        "<cmd>execute('normal! ' . v:count1 . 'N')<CR><cmd>lua require'hlslens'.start()<CR>",
        opts
      )
      vim.api.nvim_set_keymap(
        "n", "*", "*<cmd>lua require'hlslens'.start()<CR>", opts
      )
      vim.api.nvim_set_keymap(
        "n", "#", "#<cmd>lua require'hlslens'.start()<CR>", opts
      )
      vim.api.nvim_set_keymap(
        "n", "g*", "g*<cmd>lua require'hlslens'.start()<CR>", opts
      )
      vim.api.nvim_set_keymap(
        "n", "g#", "g#<cmd>lua require'hlslens'.start()<CR>", opts
      )
    end,
  }

  -- Preview the contents of register
  use { "tversteeg/registers.nvim" }

  -- Enhanced f/t
  use {
    "hrsh7th/vim-eft",
    keys = {
      { "n", "<Plug>(eft-" },
      { "o", "<Plug>(eft-" },
      { "x", "<Plug>(eft-" },
    },
    setup = require("plugins.config.vim-eft").setup,
  }

  -- Make blockwise visual mode more useful
  use {
    "kana/vim-niceblock",
    keys = { { "v", "<Plug>(niceblock-" } },
    setup = function()
      vim.g.niceblock_no_default_key_mappings = 1
      vim.api.nvim_set_keymap("v", "I", "<Plug>(niceblock-I)", {})
      vim.api.nvim_set_keymap("v", "gI", "<Plug>(niceblock-gI)", {})
      vim.api.nvim_set_keymap("v", "A", "<Plug>(niceblock-A)", {})
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
      vim.api.nvim_set_keymap("n", "J", "<Plug>(jplus)", {})
      vim.api.nvim_set_keymap("v", "J", "<Plug>(jplus)", {})
      vim.api.nvim_set_keymap("n", "<Leader>J", "<Plug>(jplus-input)", {})
      vim.api.nvim_set_keymap("v", "<Leader>J", "<Plug>(jplus-input)", {})
    end,
  }

  -- The killring-alike plugin with no default mappings.
  -- (Use this plugin until https://github.com/neovim/neovim/issues/1822 is fixed)
  use {
    "bfredl/nvim-miniyank",
    keys = { { "n", "<Plug>(miniyank-" } },
    setup = function()
      vim.g.miniyank_maxitems = 100
      vim.api.nvim_set_keymap("n", "p", "<Plug>(miniyank-autoput)", {})
      vim.api.nvim_set_keymap("n", "P", "<Plug>(miniyank-autoPut)", {})
    end,
  }

  -- Enhanced increment/decrement plugin for Neovim.
  use {
    "monaqa/dial.nvim",
    keys = { { "n", "<Plug>(dial-" }, { "v", "<Plug>(dial-" } },
    setup = function()
      vim.api.nvim_set_keymap("n", "<C-a>", "<Plug>(dial-increment)", {})
      vim.api.nvim_set_keymap("n", "<C-x>", "<Plug>(dial-decrement)", {})
      vim.api.nvim_set_keymap("v", "<C-a>", "<Plug>(dial-increment)", {})
      vim.api.nvim_set_keymap("v", "<C-x>", "<Plug>(dial-decrement)", {})
      vim.api.nvim_set_keymap(
        "v", "g<C-a>", "<Plug>(dial-increment-additional)", {}
      )
      vim.api.nvim_set_keymap(
        "v", "g<C-x>", "<Plug>(dial-decrement-additional)", {}
      )
    end,
  }

  -- A more adventurous wildmenu

  -- Show keybindings in popup
  -- use {
  --   "liuchengxu/vim-which-key",
  --   cmd = { "WhichKey", "WhichKeyVisual" },
  --   setup = require("plugins.config.vim-which-key").setup,
  --   config = require("plugins.config.vim-which-key").config,
  -- }

  -- A high-performance color highlighter for NeoVim
  use {
    "norcalli/nvim-colorizer.lua",
    cmd = {
      "ColorizerAttachToBuffer",
      "ColorizerDetachFromBuffer",
      "ColorizerReloadAllBuffers",
      "ColorizerToggle",
    },
    config = function() require'colorizer'.setup() end,
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
      vim.api.nvim_set_keymap("n", "_", "<Plug>(operator-replace)", {})
      vim.api.nvim_set_keymap("x", "_", "<Plug>(operator-replace)", {})
    end,
  }
  use {
    "machakann/vim-sandwich",
    event = "CursorHold *",
    keys = {
      { "n", "<Plug>(operator-sandwich-" },
      { "o", "<Plug>(operator-sandwich-" },
      { "x", "<Plug>(operator-sandwich-" },
      { "n", "<Plug>(textobj-sandwich-" },
      { "o", "<Plug>(textobj-sandwich-" },
      { "x", "<Plug>(textobj-sandwich-" },
    },
    setup = require("plugins.config.sandwich").setup,
    config = require("plugins.config.sandwich").config,
  }

  -- Smart align
  use {
    "junegunn/vim-easy-align",
    keys = { { "n", "<Plug>(EasyAlign)" }, { "v", "<Plug>(EasyAlign)" } },
    setup = require("plugins.config.vim-easy-align").setup,
  }

  -- SKK input method for Japanese
  use {
    "tyru/eskk.vim",
    event = "InsertCharPre *",
    config = require("plugins.config.eskk").config,
  }

  -- Perform the replacement in quickfix
  use {
    "thinca/vim-qfreplace",
    ft = { "qf" },
    config = function()
      require'core.event'.create_augroups(
        {
          user_plugin_qfreplace = {
            {
              "FileType",
              "qf",
              function()
                vim.api.nvim_buf_set_keymap(
                  0, "n", "R", "<cmd>Qfreplace<CR>", { noremap = true }
                )
              end,
            },
          },
        }
      )
    end,
  }

  -- [[ ]]
  -- Asynchronously control git repositories
  -- { "lambdalisue/gina.vim", cmd = {"Gina"} },

  -- Calling LazyGit from within neovim
  use {
    "kdheepak/lazygit.nvim",
    cmd = { "LazyGit", "LazyGitFilter", "LazyGitConfig" },
    setup = function()
      vim.g.lazygit_floating_window_winblend = 0
      vim.g.lazygit_floating_window_scaling_factor = 0.9
      vim.g.lazygit_floating_window_corner_chars =
        { '╭', '╮', '╰', '╯' }
      vim.g.lazygit_use_neovim_remote = 0
      vim.api.nvim_set_keymap(
        "n", "<Space>gl", "<cmd>LazyGit<CR>", { noremap = true, silent = true }
      )
    end,
  }

  -- Git signs written in pure lua
  use {
    "lewis6991/gitsigns.nvim",
    branch = "main",
    requires = { "nvim-lua/plenary.nvim" },
    config = require("plugins.config.gitsigns").config,
  }

  -- Reveal the commit messages under the cursor
  use {
    "rhysd/git-messenger.vim",
    cmd = { "GitMessenger" },
    keys = { "n", "<Plug>(git-messenger" },
    setup = function()
      vim.g.git_messenger_no_default_mappings = true
      vim.api.nvim_set_keymap(
        "n", "<Space>gm", "<Plug>(git-messenger)", { silent = true }
      )
    end,
  }

  -- More pleasant editing on commit messsages
  use {
    "rhysd/committia.vim",
    event = { "BufEnter COMMIT_EDITMSG" },
    setup = function() vim.g.committia_min_window_width = 100 end,
  }

  -- Git blame plugin for Neovim written in lua
  use {
    "f-person/git-blame.nvim",
    event = { "BufRead *", "BufNewFile *" },
    setup = function() vim.g.gitblame_enabled = 0 end,
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
      { "JoosepAlviste/nvim-ts-context-commentstring", opt = true },
    },
    config = require("plugins.config.treesitter").config,
  }

  -- Vim help in japanese
  use { "vim-jp/vimdoc-ja" }

  -- GNU As
  use { "Shirk/vim-gas" }

  -- Jsonc
  use { "neoclide/jsonc.vim" }

  -- Python
  use { "vim-scripts/python_match.vim" }
  use { "raimon49/requirements.txt.vim" }
  use {
    "petobens/poet-v",
    ft = { "python" },
    setup = "vim.g.poetv_auto_activate = 1",
  }
  use { "tmhedberg/SimpylFold", ft = { "python" } }

  -- Lua
  use { "tjdevries/nlua.nvim", ft = { "lua" } }
  use { "tjdevries/manillua.nvim" }

  -- Markdown
  use { "rcmdnk/vim-markdown" }
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
      vim.g.EditorConfig_exclude_patterns =
        { 'scp://.*', 'term://.*', 'gina://.*', 'fugitive://.*' }
    end,
  }

  -- Visually displaying indent levels in code
  use {
    "glepnir/indent-guides.nvim",
    config = require("plugins.config.indent_guides").config,
  }

  -- Comment plugin
  use {
    "terrortylor/nvim-comment",
    config = function()
      require('nvim_comment').setup {
        -- Linters prefer comment and line to have a space in between markers
        marker_padding = true,
        -- should comment out empty or whitespace only lines
        comment_empty = false,
        -- Should key mappings be created
        create_mappings = true,
        -- Normal mode mapping left hand side
        line_mapping = "<Leader>cc",
        -- Visual/Operator mapping left hand side
        operator_mapping = "<Leader>c",
      }
    end,
  }

  -- View and search LSP symbols, tags in Vim/Neovim
  use {
    "liuchengxu/vista.vim",
    cmd = { "Vista" },
    setup = require("plugins.config.vista").setup,
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
      "coffee",
      "lua",
      "java",
      "groovy",
      "ruby",
      "scalar",
      "kotlin",
      "r",
      "c",
      "cpp",
      "sh",
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

  -- Language Server Protocol (LSP)
  use {
    "neovim/nvim-lspconfig",
    event = { "BufRead *" },
    requires = {
      -- {"nvim-lua/lsp-status.nvim", opt = true},
      { "glepnir/lspsaga.nvim", opt = true },
    },
    config = function()
      -- vim.cmd [[packadd lsp-status.nvim]]
      vim.cmd [[packadd lspsaga.nvim]]
      require("plugins.config.lspconfig")
    end,
  }

  -- Debug Adapter Protocol client implementation for Neovim
  use {
    "mfussenegger/nvim-dap",
    ft = { "c", "cpp", "python", "rust" },
    requires = {
      { "mfussenegger/nvim-dap-python", opt = true },
      { "theHamsta/nvim-dap-virtual-text", opt = true },
    },
    config = require("plugins.config.dap").config,
  }

  -- [[ Auto completions ]]
  use {
    "hrsh7th/nvim-compe",
    requires = {
      {
        "hrsh7th/vim-vsnip",
        event = { "InsertCharPre *" },
        setup = function()
          vim.g.vsnip_snippet_dir = vim.fn.stdpath("config") .. "/snippets"
        end,
      },
    },
    event = { "InsertEnter *" },
    config = require("plugins.config.completion").config,
  }

  -- [[ Fuzzy finder ]]
  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      { "nvim-lua/popup.nvim", opt = true },
      { "nvim-lua/plenary.nvim", opt = true },
      { "kyazdani42/nvim-web-devicons", opt = true },
      { "nvim-telescope/telescope-cheat.nvim", opt = true },
      { "nvim-telescope/telescope-dap.nvim", opt = true },
      {
        "nvim-telescope/telescope-frecency.nvim",
        requires = { "tami5/sql.nvim", opt = true },
        opt = true,
      },
      { "nvim-telescope/telescope-fzf-writer.nvim", opt = true },
      { "nvim-telescope/telescope-fzy-native.nvim", opt = true },
      { "nvim-telescope/telescope-ghq.nvim", opt = true },
      { "nvim-telescope/telescope-packer.nvim", opt = true },
      { "nvim-telescope/telescope-symbols.nvim", opt = true },
    },
    cmd = { "Telescope" },
    keys = {
      "<Space>en",
      "<Space>ez",
      "<Space>fb",
      "<Space>fd",
      "<Space>fD",
      "<Space>fe",
      "<Space>ff",
      "<Space>fg",
      "<Space>fG",
      "<Space>fh",
      "<Space>fo",
      "<Space>f/",
    },
    setup = function() require("plugins.config.telescope").setup() end,
    config = function()
      for _, name in pairs {
        'nvim-web-devicons',
        'popup.nvim',
        'sql.nvim',
        'telescope-cheat.nvim',
        'telescope-frecency.nvim',
        'telescope-fzf-writer.nvim',
        'telescope-fzy-native.nvim',
        'telescope-ghq.nvim',
        'telescope-github.nvim',
        'telescope-packer.nvim',
        'telescope-symbols.nvim',
      } do vim.cmd('packadd ' .. name) end
      require("plugins.config.telescope").config()
    end,
  }
end

return M
