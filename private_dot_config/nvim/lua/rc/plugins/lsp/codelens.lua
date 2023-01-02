local M = {}

M.on_attach = function(client, bufnr)
  if client.supports_method "textDocument/codeLens" then
    local group = vim.api.nvim_create_augroup("LspCodeLensRefresh", { clear = true })
    vim.api.nvim_create_autocmd("BufEnter", {
      group = group,
      buffer = bufnr,
      once = true,
      callback = function()
        vim.lsp.codelens.refresh()
      end,
      desc = "[LSP] Refresh the codelens for the current buffer.",
    })
    vim.api.nvim_create_autocmd({ "BufWritePost", "CursorHold" }, {
      group = group,
      buffer = bufnr,
      callback = function()
        vim.lsp.codelens.refresh()
      end,
      desc = "[LSP] Refresh the codelens for the current buffer.",
    })
  end
end

return M
