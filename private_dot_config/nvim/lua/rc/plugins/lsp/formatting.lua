local M = {}

M.autoformat = true

M.toggle = function()
  M.autoformat = not M.autoformat
  if M.autoformat then
    vim.notify("enabled format on save", vim.log.levels.INFO, { title = "Formatting" })
  else
    vim.notify("disabled format on save", vim.log.levels.WARN, { title = "Formatting" })
  end
end

M.format = function(bufnr)
  if M.autoformat then
    -- Use the formatters provided by the null-ls when available.
    -- Otherwise, use the formatter provided by other LSP client(s)
    local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
    local use_null_ls = require("rc.plugins.null-ls").has_formatter(ft)
    vim.lsp.buf.format {
      filter = function(client)
        local enable = false
        if use_null_ls then
          enable = client.name == "null-ls"
        else
          enable = not (client.name == "null-ls")
        end
        if client.name == "tsserver" then
          enable = false
        end
        return enable
      end,
      bufnr = bufnr,
    }
  end
end

M.on_attach = function(client, bufnr)
  if client.supports_method "textDocument/formatting" then
    local augroup_formatting = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
    vim.api.nvim_clear_autocmds { group = augroup_formatting, buffer = bufnr }
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup_formatting,
      buffer = bufnr,
      callback = function()
        require("rc.plugins.lsp.formatting").format(bufnr)
      end,
      desc = "[LSP] format on save.",
    })
  end
end

return M
