local M = {}
local utils = require "rc.core.util"

M.autoformat = true

function M.toggle()
  M.autoformat = not M.autoformat
  if M.autoformat then
    utils.info("enabled format on save", "Formatting")
  else
    utils.info("disabled format on save", "Formatting")
  end
end

function M.format()
  if M.autoformat then
    vim.lsp.buf.formatting_sync()
  end
end

function M.setup(client, bufnr)
  local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
  local null_ls = require "rc.config.lsp.null-ls"
  local enable = false
  if null_ls.has_formatter(ft) then
    enable = client.name == "null-ls"
  else
    enable = not (client.name == "null-ls")
  end

  client.resolved_capabilities.document_formatting = enable

  -- Format on save
  if client.resolved_capabilities.document_formatting then
    vim.cmd [[
      augroup ConfigLspFormat
        autocmd! * <buffer>
        autocmd BufWritePre <buffer> lua require("rc.config.lsp.formatting").format()
      augroup END
    ]]
  end
end

return M