-- Configure lazy.nvim: a modern plugin manager

-- bootstrap from github
local lazypath = vim.fs.joinpath(vim.fn.stdpath "data", "lazy", "lazy.nvim")
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

-- load lazy.nvim
require("lazy").setup {
  spec = {
    { import = "rc.plugins" },
    { import = "rc.plugins.extras.lang.json" },
    { import = "rc.plugins.extras.lang.rust" },
    { import = "rc.plugins.extras.lang.clangd" },
    { import = "rc.plugins.extras.lang.python" },
  },
  defaults = {
    lazy = true,
  },
  install = {
    colorscheme = { "kanagawa", "habamax" },
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
