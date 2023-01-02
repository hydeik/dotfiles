local M = {}

M.setup = function()
  -- Change diagnostic symbols in the sign column (gutter)
  local icons = require "rc.core.ui.icons"
  local diagnostic_icons = {
    Error = icons.diagnostics.Error_alt,
    Warn = icons.diagnostics.Warning_alt,
    Info = icons.diagnostics.Information_alt,
    Hint = icons.diagnostics.Hint_alt,
  }
  for type, icon in pairs(diagnostic_icons) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl })
  end

  -- Diagnostic config
  vim.diagnostic.config {
    underline = true,
    virtual_text = {
      source = "always",
    },
    signs = {
      priority = 20,
    },
    float = {
      source = "always",
      border = "single",
    },
    update_in_insert = false,
    severity_sort = true,
  }
end

return M
