-- Change diagnostic symbols in the sign column (gutter)
local signs = { Error = "", Warning = "", Info = "", Hint = "" }

for type, icon in pairs(signs) do
  local hl = "LspDiagnosticsSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- Handlers
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  severity_sort = true,
  signs = { priority = 20 },
  underline = true,
  update_in_insert = false,
  virtual_text = true,
})
