local M = {}

function M.setup(client)
  if client.resolved_capabilities.code_lens then
    vim.cmd [[
      augroup ConfigLspCodeLens
      autocmd! * <buffer>
      autocmd BufWritePost,CursorHold <buffer> lua vim.lsp.buf.codelens.refresh()
      augroup END
    ]]
  end
end

return M
