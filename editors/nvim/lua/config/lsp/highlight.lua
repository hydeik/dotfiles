local M = {}

function M.setup(client)
  if client.resolved_capabilities.document_highlight then
    vim.cmd [[
      augroup ConfigLspDocumentHighlight
      autocmd! * <buffer>
      autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]]
  end
end

return M
