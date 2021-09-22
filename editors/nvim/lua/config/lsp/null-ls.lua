local M = {}

function M.setup()
  local null_ls = require "null-ls"
  null_ls.config {
    debounce = 150,
    save_after_format = false, -- toggle manually
    sources = {
      null_ls.builtins.formatting.black,
      null_ls.builtins.formatting.cmake_format,
      null_ls.builtins.formatting.prettier.with {
        filetypes = { "html", "json", "yaml", "markdown" },
      },
      null_ls.builtins.formatting.shfmt.with {
        args = { "-ln", "bash", "-i", "2", "-bn", "-ci", "-sr", "-kp" },
      },
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.diagnostics.shellcheck,
      null_ls.builtins.code_actions.gitsigns,
    },
  }
end

function M.has_formatter(ft)
  local config = require("null-ls.config").get()
  local formatters = config._generators["NULL_LS_FORMATTING"]
  for _, f in ipairs(formatters) do
    if vim.tbl_contains(f.filetype, ft) then
      return true
    end
  end
end

return M
