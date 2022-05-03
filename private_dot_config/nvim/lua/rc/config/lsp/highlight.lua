local M = {}

function M.setup(client, bufnr)
  if client.server_capabilities.document_highlight then
    local group = vim.api.nvim_create_augroup("ConfigLspDocumentHighlight", { clear = true })
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
