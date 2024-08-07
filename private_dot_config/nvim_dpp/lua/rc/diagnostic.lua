-- Global diagnostic configurations

-- diagnostic signs
for name, icon in pairs(require("rc.core.settings").icons.diagnostics) do
  local hl = "DiagnosticSign" .. name
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- options for vim.diagnostic.config()
local opts = {
  underline = true,
  virtual_text = {
    source = "always",
    prefix = vim.fn.has "nvim-0.10.0" == 0 and "●" or function(diagnostic)
      local icons = require("rc.core.config").icons.diagnostics
      for d, icon in pairs(icons) do
        if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
          return icon
        end
      end
    end,
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

vim.diagnostic.config(opts.diagnostics)
