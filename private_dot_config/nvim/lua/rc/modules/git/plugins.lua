local plugin = require("rc.core.pack").register_plugin
local conf = require("rc.modules.git.config")

-- A Vim plugin for more pleasant editing on commit messages
plugin {
  "rhysd/committia.vim",
  ft = { "gitcommit" },
  setup = conf.committia_vim.setup,
}

-- Vim and Neovim plugin to reveal the commit messages under the cursor.
plugin {
  "rhysd/git-messenger.vim",
  cmd = { "GitMessenger" },
  keys = {
    { "n", "<Plug>(git-messenger" },
  },
  setup = conf.git_messenger_vim.setup,
}

-- A lua neovim plugin to generate shareable file permalinks (with line ranges) for several git web frontend hosts.
-- Inspired by tpope/vim-fugitive's :GBrowse
plugin {
  "ruifm/gitlinker.nvim",
  requires = { "plenary.nvim" },
  module = { "gitlinker" },
  setup = conf.gitlinker.setup,
  config = conf.gitlinker.config,
}

-- Git integration for buffers
plugin {
  "lewis6991/gitsigns.nvim",
  branch = "main",
  event = { "FocusLost", "CursorHold" },
  module = { "gitsigns" },
  requires = { "plenary.nvim" },
  config = conf.gitsigns.config,
}

-- Plugin for calling LazyGit from within neovim
plugin {
  "kdheepak/lazygit.nvim",
  cmd = { "LazyGit", "LazyGitFilter", "LazyGitConfig" },
  setup = conf.lazygit_nvim.setup,
}
