local plugin = require("rc.core.pack").register_plugin
local conf = require("rc.modules.editor.config")

-- EditorConfig plugin for Vim
plugin {
  "editorconfig/editorconfig-vim",
  event = { "BufNewFile", "BufRead" },
}

-- [Comment out]

-- Smart and powerful comment plugin for neovim.
-- Supports treesitter, dot repeat, left-right/up-down motions, hooks, and more.
plugin {
  "numToStr/Comment.nvim",
  keys = { "gc", "gb", "gcc", "gbc" },
  requires = { "nvim-ts-context-commentstring" },
  config = conf.comment_nvim.config,
}


-- [Selection]
-- Make blockwise visual mode more useful
plugin {
  "kana/vim-niceblock",
  keys = {
    { "v", "<Plug>(niceblock-" }
  },
  setup = conf.vim_niceblock.setup,
}

-- [Alignment]
-- A Vim alignment plugin
plugin {
  "junegunn/vim-easy-align",
  keys = {
    { "n", "<Plug>(EasyAlign)" },
    { "v", "<Plug>(EasyAlign)" },
  },
  setup = conf.vim_easy_align.setup,
  config = conf.vim_easy_align.config,
}

-- [textobj/operator]
-- Vim plugin: Define your own operator easily
plugin { "kana/vim-operator-user" }

-- Vim plugin: Create your own text objects
plugin { "kana/vim-textobj-user" }

-- A Vim plugin to provide some operators to convert a word case.
plugin {
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
  setup = conf.vim_operator_convert_case.setup,
}

-- Set of operators and textobjects to search/select/edit sandwiched texts.
plugin {
  "machakann/vim-sandwich",
  event = { "CursorHold" },
  keys = {
    { "n", "<Plug>(sandwich-" },
    { "x", "<Plug>(sandwich-" },
    { "o", "<Plug>(sandwich-" },
    { "o", "<Plug>(operator-sandwich-" },
    { "x", "<Plug>(operator-sandwich-" },
    { "o", "<Plug>(textobj-sandwich-" },
    { "x", "<Plug>(textobj-sandwich-" },
  },
  setup = conf.vim_sandwich.setup,
  config = conf.vim_sandwich.config,
}

-- Neovim plugin introducing a new operators motions to quickly replace and exchange text.
-- TODO: add config & keymaps
plugin {
  "gbprod/substitute.nvim",
}
