-- Configure lazy.nvim: a modern plugin manager

-- bootstrap from github
local data_home = vim.fn.stdpath "data" --[[@as string]]
local lazypath = vim.fs.joinpath(data_home, "lazy", "lazy.nvim")
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  }
end
vim.opt.runtimepath:prepend(lazypath)

local specs = {
  --[[ Fundamental plugins ]]
  { "folke/lazy.nvim", version = "*" },
  { "nvim-lua/plenary.nvim", lazy = true },
  { "kkharji/sqlite.lua", lazy = true },
  { "rafamadriz/friendly-snippets", lazy = false },
  { "brianhuster/unnest.nvim", lazy = false },
  { import = "rc.plugins.snacks.core" },

  -- [[ Colorscheme ]]
  { import = "rc.plugins.catppuccin" },
  { import = "rc.plugins.kanagawa" },

  -- [[ Treesitter ]]
  { import = "rc.plugins.treesitter" },

  -- [[ Completion ]]
  { import = "rc.plugins.blink" },

  -- [[ Coding ]]
  { import = "rc.plugins.mini.ai" },
  { import = "rc.plugins.mini.surround" },
  { import = "rc.plugins.dial" },
  { import = "rc.plugins.nvim-insx" },
  { import = "rc.plugins.operator-convert-case" },
  { import = "rc.plugins.quicker" },
  { import = "rc.plugins.ts-comments" },
  { import = "rc.plugins.yanky" },

  -- [[ Editor enrichment ]]
  { import = "rc.plugins.gitsigns" },
  { import = "rc.plugins.flash" },
  { import = "rc.plugins.trouble" },
  { import = "rc.plugins.todo-comments" },
  { import = "rc.plugins.which-key" },

  -- [[ LSP / Formatter / Linter / Dap ]]
  { import = "rc.plugins.lazydev" },
  { import = "rc.plugins.formatting.core" },
  { import = "rc.plugins.linting.core" },
  { import = "rc.plugins.lsp.core" },
  { import = "rc.plugins.dap.core" },

  -- [[ UI ]]
  { "MunifTanjim/nui.nvim", lazy = true },
  { import = "rc.plugins.mini.icons" },
  { import = "rc.plugins.noice" },
  { import = "rc.plugins.snacks.ui" },
  { import = "rc.plugins.snacks.dashboard" },

  -- [[ Fuzzy Finder / Filer ]]
  { import = "rc.plugins.oil" },
  { import = "rc.plugins.snacks.picker" },
  { import = "rc.plugins.snacks.explorer" },

  -- [[ Utilities ]]
  { import = "rc.plugins.ccc" },
  { import = "rc.plugins.gitlinker" },
  { import = "rc.plugins.inc-rename" },
  { import = "rc.plugins.smart-splits" },
  { import = "rc.plugins.snacks.utils" },

  -- [[ Statusline ]]
  { import = "rc.plugins.nvim-navic" },
  { import = "rc.plugins.heirline.core" },

  -- [[ AI assistance ]]
  { import = "rc.plugins.ai.copilot" },
  { import = "rc.plugins.ai.codecompanion" },
  { import = "rc.plugins.ai.mcphub" },

  -- [[ Program Languages ]]
  { import = "rc.plugins.lang.bash" }, -- for bash, sh, and zsh
  { import = "rc.plugins.lang.biome" },
  { import = "rc.plugins.lang.fortran" },
  { import = "rc.plugins.lang.git" },
  { import = "rc.plugins.lang.json" },
  { import = "rc.plugins.lang.markdown" },
  { import = "rc.plugins.lang.nix" },
  { import = "rc.plugins.lang.python" },
  { import = "rc.plugins.lang.rust" },
  { import = "rc.plugins.lang.toml" },
  { import = "rc.plugins.lang.yaml" },
}

-- load lazy.nvim
require("lazy").setup {
  spec = specs,
  defaults = {
    lazy = true,
  },
  install = {
    colorscheme = { "catppucin", "habamax" },
  },
  checker = {
    enabled = true,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "2html_plugin",
        "getscript",
        "getscriptPlugin",
        "gzip",
        "logiPat",
        "man",
        "matchit",
        "matchparen",
        "ogx",
        "netrwFileHandlers",
        "netrwPlugin",
        "netrwSettings",
        "rrhelper",
        "spellfile_plugin",
        "tar",
        "tarPlugin",
        "tutor_mode_plugin",
        "vimball",
        "vimballPlugin",
        "zip",
        "zipPlugin",
      },
    },
  },
  debug = true,
}
