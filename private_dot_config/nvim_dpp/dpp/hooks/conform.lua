--- [conform.nvim](https://github.com/stevearc/conform.nvim)
--- Lightweight yet powerful formatter plugin for Neovim

-- lua_add {{{

-- mapping
vim.keymap.set("", "<Space>cf", function()
  require("conform").format { async = true, lsp_fallback = true }
end, { silent = true, desc = "Format buffer" })

-- formatexpr
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

-- install formater via mason
-- vim.g.mason_ensure_installed = vim.list_extend(vim.g.mason_ensure_installed, {
--   "cmakelang",
--   "fixjson",
--   "prettierd",
--   "stylua",
--   "shfmt",
-- })

-- }}}

-- lua_source {{{

-- Install formater via mason
local formatters = {
  "cmakelang",
  "fixjson",
  "stylua",
  "shfmt",
}

require("rc.plugins.mason").ensure_installed(formatters)

-- Only run stylua when we can find a root dir
require("conform.formatters.stylua").require_cwd = true

-- setup
require("conform").setup {
  formatters_by_ft = {
    cmake = { "cmake_format" },
    jsonc = { "fixjson" },
    lua = { "stylua" },
    sh = { "shfmt" },
  },
  -- Set up format-on-save
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
  -- Customize formatters
  formatters = {
    shfmt = {
      prepend_args = { "-ln", "bash", "-i", "2", "-bn", "-ci", "-sr", "-kp" },
    },
  },
}

-- command
vim.api.nvim_create_user_command("Format", function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ["end"] = { args.line2, end_line:len() },
    }
  end
  require("conform").format { async = true, lsp_fallback = true, range = range }
end, { range = true })

-- }}}
