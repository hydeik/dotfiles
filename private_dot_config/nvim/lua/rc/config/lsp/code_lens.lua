local M = {}

function M.setup(client)
  if client.resolved_capabilities.code_lens then
    vim.cmd [[
      augroup ConfigLspCodeLens
      autocmd! * <buffer>
      autocmd BufEnter ++once         <buffer> lua require"vim.lsp.codelens".refresh()
      autocmd BufWritePost,CursorHold <buffer> lua require"vim.lsp.codelens".refresh()
      augroup END
    ]]
  end
end

return M
