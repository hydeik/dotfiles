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
    config = function()
      vim.g.cursorhold_updatetime = 100
    end,
  }

  -- tmux integration for nvim features pane movement and resizing from within nvim.
  use {
    "aserowy/tmux.nvim",
    module = { "tmux" },
    setup = function()
      -- Custom keybindings
      local opts = { silent = true, nowait = true }
      vim.keymap.set("n", "<M-h>", "<Cmd>lua require('tmux').move_left()<CR>", opts)
      vim.keymap.set("n", "<M-j>", "<Cmd>lua require('tmux').move_bottom()<CR>", opts)
      vim.keymap.set("n", "<M-k>", "<Cmd>lua require('tmux').move_top()<CR>", opts)
      vim.keymap.set("n", "<M-l>", "<Cmd>lua require('tmux').move_right()<CR>", opts)

      vim.keymap.set("n", "<C-M-h>", "<Cmd>lua require('tmux').resize_left()<CR>", opts)
      vim.keymap.set("n", "<C-M-j>", "<Cmd>lua require('tmux').resize_bottom()<CR>", opts)
      vim.keymap.set("n", "<C-M-k>", "<Cmd>lua require('tmux').resize_top()<CR>", opts)
      vim.keymap.set("n", "<C-M-l>", "<Cmd>lua require('tmux').resize_right()<CR>", opts)
    end,
    config = function()
      require("tmux").setup {
        navigation = { enable_default_keybindings = false },
        resize = {
          enable_default_keybindings = false,
          resize_step_x = 2,
          resize_step_y = 2,
        },
      }
    end,
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
    config = function()
      require("bufferline").setup { options = { always_show_bufferline = true } }
    end,
  }

  -- A fancy, configurable, notification manager for Neovim
  use {
    "rcarriga/nvim-notify",
    module = "notify",
  }

  -- Better whitespace highlighting
  use {
    "ntpeters/vim-better-whitespace",
    event = { "BufNewFile", "BufRead" },
    setup = function()
      vim.g.better_whitespace_enabled = 1
      vim.g.strip_whitespace_on_save = 1
      vim.g.show_spaces_that_precede_tabs = 1
      vim.g.better_whitespace_filetypes_blacklist = {
        "diff",
        "gitcommit",
        "defx",
        "denite",
        "qf",
        "help",
        "markdown",
        "packer",
        "which_key",
      }
      -- keymap
      vim.keymap.set("n", "<Leader>x", "<Cmd>StripWhitespace<CR>", { silent = true })
    end,
  }

  -- -- A file explorer tree for neovim written in lua
  -- use {
  --   "kyazdani42/nvim-tree.lua",
  --   cmd = { "NvimTreeToggle", "NvimTreeRefresh", "NvimTreeFindFile" },
  --   setup = [[require("rc.config.nvim-tree").setup()]],
  --   config = [[require("rc.config.nvim-tree").config()]],
  --   disable = true,
  -- }

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
    setup = function()
      -- Overwrite / and ?.
      vim.keymap.set({ "n", "x" }, "?", "<Cmd>call searchx#start({ 'dir': 0 })<CR>")
      vim.keymap.set({ "n", "x" }, "/", "<Cmd>call searchx#start({ 'dir': 1 })<CR>")
      vim.keymap.set("n", "'", "<Cmd>call searchx#select()<CR>)")
      -- Move to next/prev match
      vim.keymap.set({ "n", "x" }, "N", "<Cmd>call searchx#prev_dir()<CR>")
      vim.keymap.set({ "n", "x" }, "n", "<Cmd>call searchx#next_dir()<CR>")
      vim.keymap.set({ "n", "x", "c" }, "<C-j>", "<Cmd>call searchx#next()<CR>")
      vim.keymap.set({ "n", "x", "c" }, "<C-k>", "<Cmd>call searchx#prev()<CR>")
      -- Clear highlights
      vim.keymap.set("n", "<Esc><Esc>", "<Cmd>call searchx#clear()<CR>)")
    end,
    config = [[require("rc.config.vim-searchx")]],
  }

  -- Enhanced f/t
  use {
    "hrsh7th/vim-eft",
    keys = {
      { "n", "<Plug>(eft-" },
      { "o", "<Plug>(eft-" },
      { "x", "<Plug>(eft-" },
    },
    setup = function()
      vim.keymap.set({ "n", "x", "o" }, "f", "<Plug>(eft-f-repeatable)")
      vim.keymap.set({ "n", "x", "o" }, "F", "<Plug>(eft-F-repeatable)")
      vim.keymap.set({ "n", "x", "o" }, "t", "<Plug>(eft-t-repeatable)")
      vim.keymap.set({ "n", "x", "o" }, "T", "<Plug>(eft-T-repeatable)")
    end,
  }

  -- Neovim motions on speed!
  use {
    "phaazon/hop.nvim",
    -- keys = {
    --   { "n", "ss" },
    --   { "o", "ss" },
    --   { "x", "ss" },
    --   { "n", "sl" },
    --   { "o", "sl" },
    --   { "x", "sl" },
    --   { "n", "s/" },
    --   { "o", "s/" },
    --   { "x", "s/" },
    -- },
    module = { "hop" },
    setup = function()
      vim.keymap.set({ "n", "x", "o" }, "ss", "<Cmd>lua require'hop'.hint_char2()<CR>")
      vim.keymap.set({ "n", "x", "o" }, "sl", "<Cmd>lua require'hop'.hint_lines()<CR>")
      vim.keymap.set({ "n", "x", "o" }, "s/", "<Cmd>lua require'hop'.hint_patterns()<CR>")
    end,
    config = function()
      require("hop").setup()
    end,
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

  -- Show keybindings in popup
  use {
    "folke/which-key.nvim",
    config = [[require("rc.config.which-key")]],
  }

  -- A high-performance color highlighter for NeoVim
  use {
    "norcalli/nvim-colorizer.lua",
    event = "BufReadPre",
    config = function()
      require("colorizer").setup(nil, {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        names = true, -- "Name" codes like Blue
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
        -- Available modes: foreground, background
        mode = "background", -- Set the display mode.
      })
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
    setup = function()
      vim.g.sandwich_no_default_key_mappings = 1
      vim.g.operator_sandwich_no_default_key_mappings = 1
      vim.g.textobj_sandwich_no_default_key_mappings = 1

      -- Key mappings
      -- add
      vim.keymap.set("", "sa", "<Plug>(sandwich-add)")

      -- delete
      vim.keymap.set({ "n", "x" }, "sd", "<Plug>(sandwich-delete)")
      vim.keymap.set("n", "sdb", "<Plug>(sandwich-delete-auto)")

      -- replace
      vim.keymap.set({ "n", "x" }, "sr", "<Plug>(sandwich-replace)")
      vim.keymap.set("n", "srb", "<Plug>(sandwich-replace-auto)")

      -- textobj auto
      vim.keymap.set({ "o", "x" }, "ab", "<Plug>(textobj-sandwich-auto-a)")
      vim.keymap.set({ "o", "x" }, "ib", "<Plug>(textobj-sandwich-auto-i)")

      -- textobj query
      vim.keymap.set({ "o", "x" }, "as", "<Plug>(textobj-sandwich-query-a)")
      vim.keymap.set({ "o", "x" }, "is", "<Plug>(textobj-sandwich-query-i)")
    end,
    config = function()
      vim.g["textobj#sandwich#stimeoutlen"] = 100
      vim.api.nvim_exec(
        [=[
          let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)
          let g:sandwich#recipes += [{'buns': ['「', '」']}, {'buns': ['【', '】']}]
          let g:sandwich#recipes += [{'buns': ['（', '）']}, {'buns': ['『', '』']}]
          let g:sandwich#recipes += [{'buns': ['\(',  '\)'], 'filetype': ['vim'], 'nesting': 1}]
          let g:sandwich#recipes += [{'buns': ['\%(', '\)'], 'filetype': ['vim'], 'nesting': 1}]
        ]=],
        false
      )
    end,
  }

  -- Smart align
  use {
    "junegunn/vim-easy-align",
    keys = {
      { "n", "<Plug>(EasyAlign)" },
      { "v", "<Plug>(EasyAlign)" },
    },
    setup = function()
      -- key mappings
      vim.keymap.set({ "n", "v" }, "<Leader>a", "<Plug>(EasyAlign)", { silent = true })
      -- extending alignment rules
      vim.g.easy_align_delimiters = {
        [">"] = { pattern = [[>>\|=>\|>]] },
        ["/"] = { pattern = [[//\+\|/\*\|\*/]], ignore_groups = { "String" } },
        ["#"] = {
          pattern = [[#\+]],
          ignore_groups = { "String" },
          delimiter_align = "l",
        },
        ["]"] = {
          pattern = [=[[[\]]]=],
          left_margin = 0,
          right_margin = 0,
          stick_to_left = 0,
        },
        [")"] = {
          pattern = "[()]",
          left_margin = 0,
          right_margin = 0,
          stick_to_left = 0,
        },
        ["d"] = {
          pattern = [[ \(\S\+\s*[;=]\)\@=]],
          left_margin = 0,
          right_margin = 0,
        },
      }
    end,
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
      vim.keymap.set("n", "<Space>gl", "<Cmd>LazyGit<CR>", { silent = true })
    end,
  }

  -- Git signs written in pure lua
  use {
    "lewis6991/gitsigns.nvim",
    branch = "main",
    event = { "FocusLost", "CursorHold" },
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("gitsigns").setup {
        signs = {
          add = { hl = "DiffAdd", text = "│", numhl = "GitSignsAddNr" },
          change = { hl = "DiffChange", text = "│", numhl = "GitSignsChangeNr" },
          delete = { hl = "DiffDelete", text = "_", numhl = "GitSignsDeleteNr" },
          topdelete = { hl = "DiffDelete", text = "‾", numhl = "GitSignsDeleteNr" },
          changedelete = { hl = "DiffChange", text = "~", numhl = "GitSignsChangeNr" },
        },
        numhl = true,
        word_diff = true,
      }
    end,
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
    setup = function()
      vim.g.committia_min_window_width = 100
    end,
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
      vim.keymap.set("x", "iu", ":lua require('treesitter-unit').select()<CR>", { silent = true })
      vim.keymap.set("x", "au", ":lua require('treesitter-unit').select(true)<CR>", { silent = true })
      vim.keymap.set("o", "iu", ":<C-u>lua require('treesitter-unit').select()<CR>", { silent = true })
      vim.keymap.set("o", "au", ":<C-u>lua require('treesitter-unit').select(true)<CR>", { silent = true })
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
    "numToStr/Comment.nvim",
    keys = { "gc", "gb", "gcc", "gbc" },
    requires = { "JoosepAlviste/nvim-ts-context-commentstring", opt = true },
    wants = { "nvim-ts-context-commentstring" },
    config = function()
      require("Comment").setup {
        ---LHS of toggle mappings in NORMAL + VISUAL mode
        ---@type table
        toggler = {
          ---line-comment keymap
          line = "gcc",
          ---block-comment keymap
          block = "gbc",
        },

        ---LHS of operator-pending mappings in NORMAL + VISUAL mode
        ---@type table
        opleader = {
          ---line-comment keymap
          line = "gc",
          ---block-comment keymap
          block = "gb",
        },

        ---Create basic (operator-pending) and extended mappings for NORMAL + VISUAL mode
        ---@type table
        mappings = {
          ---operator-pending mapping
          ---Includes `gcc`, `gcb`, `gc[count]{motion}` and `gb[count]{motion}`
          ---NOTE: These mappings can be changed individually by `opleader` and `toggler` config
          basic = true,
          ---extra mapping
          ---Includes `gco`, `gcO`, `gcA`
          extra = true,
          ---extended mapping
          ---Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
          extended = false,
        },
        ---Pre-hook, called before commenting the line
        ---@type function
        pre_hook = function(ctx)
          -- Only calculate commentstring for tsx filetypes
          if vim.bo.filetype == "typescriptreact" then
            local U = require "Comment.utils"

            -- Detemine whether to use linewise or blockwise commentstring
            local type = ctx.ctype == U.ctype.line and "__default" or "__multiline"

            -- Determine the location where to calculate commentstring from
            local location = nil
            if ctx.ctype == U.ctype.block then
              location = require("ts_context_commentstring.utils").get_cursor_location()
            elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
              location = require("ts_context_commentstring.utils").get_visual_start_location()
            end

            return require("ts_context_commentstring.internal").calculate_commentstring {
              key = type,
              location = location,
            }
          end
        end,
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
      vim.keymap.set("n", "ms", "<Cmd>SymbolsOutline<CR>", { silent = true })
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
    config = [[require "rc.config.lsp"]],
  }

  use {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    event = { "BufReadPre" },
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
    config = function()
      require("trouble").setup {}
    end,
  }

  -- Standalone UI for nvim-lsp progress. Eye candy for the impatient.
  use {
    "j-hui/fidget.nvim",
    after = { "nvim-lspconfig" },
    config = function()
      require("fidget").setup {}
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
    setup = function()
      require("rc.config.dap").setup()
    end,
    config = function()
      require("rc.config.dap").config()
    end,
  }

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
    event = "InsertEnter *",
    requires = {
      { "L3MON4D3/LuaSnip" },
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
    config = function()
      require("rc.config.nvim-cmp").config()
    end,
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
