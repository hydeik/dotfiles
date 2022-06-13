local M = {}

function M.load_plugins(use, use_rock)
  local register = function(name)
    require(string.format("rc.plugins.%s", name))(use, use_rock)
    --use(require(string.format("rc.plugins.%s", name)))
  end

  local plugins_list = {
    -- Plugin manager
    "packer",
    -- Improved startup time
    "impatient",
    -- Lua libraries
    "plenary",
    "sqlite",
    "popup",
    "nui",
    "nvim-notify",
    "nvim-web-devicons",
    "FixCursorHold",
    "vim-repeat",
    -- Auto completion
    "luasnip",
    "nvim-autopairs",
    "nvim-cmp",
    -- Fuzzy finder
    "telescope",
    -- Treesitter
    "nvim-treesitter",
    "iswap",
    "treesitter-unit",
    "nvim_context_vt",
    -- Colorschemes
    "nightfox",
    -- UI
    "nvim-bufferline",
    "satellite",
    -- Highlight
    "mini",
    "nvim-colorizer",
    "todo-comments",
    "modes",
    -- Motion
    "tmux",
    "vim-eft",
    "hop",
    "vim-wordmotion",
    -- Editor
    -- (comment out)
    "Comment",
    -- (selection)
    "vim-niceblock",
    -- (alignment)
    "vim-easy-align",
    -- (textobj/operator)
    "vim-operator-user",
    "vim-textobj-user",
    "vim-operator-convert-case",
    "vim-sandwich",
    "substitute",
    -- Other standard feature enhancement
    -- (handling numbers)
    "vim-rengbang",
    "dial",
    -- (Yank)
    "registers",
    -- (Paste)
    "nvim-pasta",
    -- (Search)
    "nvim-hlslens",
    -- (Fold)
    -- (Quickfix)
    "nvim-bqf",
    "replacer",
    -- (Profiling)
    "startuptime",
    -- Coding
    "editorconfig-vim",
    "indent-blankline",
    -- (Git/Github)
    "committia",
    "git-messenger",
    "gitsigns",
    "gitlinker",
    "lazygit",
    -- Language specific
    -- (HTML)
    "nvim-ts-autotag",
    -- Debug Adaptor Protocol (DAP)
    "nvim-dap",
  }

  for _, name in ipairs(plugins_list) do
    local ok, plug = pcall(require, string.format("rc.plugins.%s", name))
    if not ok then
      local msg = "failed to load config for " .. name
      vim.api.nvim_echo({ { "Packer: ", "DiagnosticError" }, { msg } }, true, {})
    end
    use(plug)
    -- use(require(string.format("rc.plugins.%s", name)))
  end

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

end

return M
