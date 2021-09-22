require "config.lsp.diagnostics"
require("config.lsp.kind").setup()

-- custom 'on_attach' function
local function on_attach(client, bufnr)
  require("config.lsp.formatting").setup(client, bufnr)
  require("config.lsp.keymap").setup(client, bufnr)
  require("config.lsp.highlight").setup(client)
  require("config.lsp.code_lens").setup(client)
end

local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
updated_capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown" }
updated_capabilities.textDocument.completion.completionItem.snippetSupport = true
updated_capabilities.textDocument.completion.completionItem.preselectSupport = true
updated_capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
updated_capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
updated_capabilities.textDocument.completion.completionItem.deprecatedSupport = true
updated_capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
updated_capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
updated_capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}
