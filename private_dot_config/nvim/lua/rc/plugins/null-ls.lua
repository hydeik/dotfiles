-- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua.
local M = {
  "jose-elias-alvarez/null-ls.nvim",
  dependencies = {
    "mason.nvim",
    {
      "jay-babu/mason-null-ls.nvim",
      cmd = { "NullLsInstall", "NullLsUninstall" },
    },
  },
  opts = function()
    local null_ls = require "null-ls"
    return {
      debounce = 150,
      root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "json.git", "Makefile"),
      sources = {
        null_ls.builtins.code_actions.gitsigns,
        null_ls.builtins.code_actions.shellcheck,
        null_ls.builtins.diagnostics.markdownlint,
        null_ls.builtins.diagnostics.shellcheck,
        null_ls.builtins.diagnostics.vint,
        -- null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.cmake_format,
        null_ls.builtins.formatting.fixjson.with {
          filetypes = { "jsonc" },
        },
        null_ls.builtins.formatting.prettierd,
        null_ls.builtins.formatting.shfmt.with {
          args = { "-ln", "bash", "-i", "2", "-bn", "-ci", "-sr", "-kp" },
        },
        null_ls.builtins.formatting.stylua,
      },
    }
  end,
  config = function(_, opts)
    require("null-ls").setup(opts)
    require("mason-null-ls").setup {
      ensure_installed = {},
      automatic_installation = true,
      automatic_setup = false,
    }
  end,
}

---Test if null-ls sets a formatter for the given filetype
---@param ft string
M.has_formatter = function(ft)
  local sources = require "null-ls.sources"
  local available = sources.get_available(ft, "NULL_LS_FORMATTING")
  return #available > 0
end

return M
