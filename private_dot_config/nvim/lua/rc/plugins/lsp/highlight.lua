local M = {}

M.on_attach = function(client, bufnr)
  if client.supports_method "textDocument/documentHighlight" then
    local group = vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = true })
    vim.api.nvim_clear_autocmds { group = group, buffer = bufnr }
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      group = group,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.document_highlight()
      end,
      desc = "[LSP] Document highlights for the current text position.",
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      group = group,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.clear_references()
      end,
      desc = "[LSP] Turn off document highlights.",
    })
  end
end

return M
