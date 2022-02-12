-- Change diagnostic symbols in the sign column (gutter)
local signs = { Error = "", Warning = "", Info = "", Hint = "" }

for type, icon in pairs(signs) do
  local hl = "LspDiagnosticsSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
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
