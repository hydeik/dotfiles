--- [nvim-lint](https://github.com/mfussenegger/nvim-lint)
--- An asynchronous linter plugin for Neovim complementary to the built-in Language Server Protocol support.

-- lua_source {{{

-- install linter via mason
local linters = {
  "cmakelint",
  "shellcheck",
  "vale",
  "vint",
}

require("rc.plugins.mason").ensure_installed(linters)

-- Setup
require("lint").linters_by_ft = {
  cmake = { "cmakelint" },
  markdown = { "vale" },
  sh = { "shellcheck" },
  vim = { "vint" },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  group = vim.api.nvim_create_augroup("NvimLintConfig", {}),
  pattern = "*",
  callback = function()
    require("lint").try_lint()
  end,
  desc = "Trigger linting after saving buffer",
})

-- }}}
