local M = {}

function M.setup(client, bufnr)
  if client.server_capabilities.code_lens then
    vim.api.nvim_create_augroup("ConfigLspCodeLens", { clear = true })
    vim.api.nvim_create_autocmd("BufEnter", {
      group = "ConfigLspCodeLens",
      buffer = bufnr,
      once = true,
      callback = function()
        vim.lsp.codelens.refresh()
      end,
      desc = "[LSP] Refresh the codelens for the current buffer.",
    })
    vim.api.nvim_create_autocmd({ "BufWritePost", "CursorHold" }, {
      group = "ConfigLspCodeLens",
      buffer = bufnr,
      callback = function()
        vim.lsp.codelens.refresh()
      end,
      desc = "[LSP] Refresh the codelens for the current buffer.",
    })
  end
end

return M
