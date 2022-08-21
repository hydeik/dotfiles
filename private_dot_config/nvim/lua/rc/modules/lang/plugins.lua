local plugin = require("rc.core.pack").register_plugin

-- [[ Vimdoc ]]
-- A project which translate Vim documents into Japanese.
plugin { "vim-jp/vimdoc-ja" }

-- The luv docs in vimdoc format.
plugin { "nanotee/luv-vimdocs" }

-- [[ Python ]]
-- Vim Meets Poetry and Pipenv Virtual Environments
plugin {
  "petobens/poet-v",
  ft = { "python" },
  setup = function()
    vim.g.poetv_auto_activate = 1
  end
}

-- [[ Markdown ]]
-- markdown preview plugin for (neo)vim
plugin {
  "iamcco/markdown-preview.nvim",
  ft = { "markdown" },
  run = ":call mkdp#util#install()",
}

plugin {
  "mattn/vim-maketable",
  ft = { "markdown" },
  cmd = { "MakeTable", "UnmakeTable" },
}

-- [[ Zsh ]]
-- Official Vim Runtime Files for Zsh
-- plugin { "chrisbra/vim-zsh" }
