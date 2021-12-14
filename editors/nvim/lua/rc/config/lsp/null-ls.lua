local M = {}

function M.setup(opts)
  local null_ls = require "null-ls"
  null_ls.setup {
    debounce = 150,
    save_after_format = false, -- toggle manually
    sources = {
      null_ls.builtins.formatting.black,
      null_ls.builtins.formatting.cmake_format,
      null_ls.builtins.formatting.fixjson.with {
        filetypes = { "jsonc" },
      },
      null_ls.builtins.formatting.prettierd,
      null_ls.builtins.formatting.shfmt.with {
        args = { "-ln", "bash", "-i", "2", "-bn", "-ci", "-sr", "-kp" },
      },
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.diagnostics.markdownlint,
      null_ls.builtins.diagnostics.shellcheck,
      null_ls.builtins.code_actions.gitsigns,
    },
    on_attach = opts.on_attach,
  }
end

function M.has_formatter(ft)
  local sources = require "null-ls.sources"
  local available = sources.get_available(ft, "NULL_LS_FORMATTING")
  return #available > 0
end

return M
