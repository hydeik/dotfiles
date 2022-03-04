local M = {}

function M.setup(client, bufnr)
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_create_augroup("ConfigLspDocumentHighlight", { clear = true })
    vim.api.nvim_create_autocmd("CursorHold", {
      group = "ConfigLspDocumentHighlight",
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.document_highlight()
      end,
      desc = "[LSP] Document highlights for the current text position.",
    })
    vim.api.nvim_create_autocmd("CursorHold", {
      group = "ConfigLspDocumentHighlight",
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.clear_references()
      end,
      desc = "[LSP] Turn off document highlights.",
    })
  end
end

return M
