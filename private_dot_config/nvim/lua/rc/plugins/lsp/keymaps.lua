local M = {}

--@param string|nil  severity for vim.diagnostics
M.diagnostic_goto_next = function(severity_key)
  local severity = severity_key and vim.diagnostic.severity[severity_key] or nil
  return function()
    vim.diagnostic.goto_next { severity = severity }
  end
end

--@param string|nil  severity for vim.diagnostics
M.diagnostic_goto_prev = function(severity_key)
  local severity = severity_key and vim.diagnostic.severity[severity_key] or nil
  return function()
    vim.diagnostic.goto_prev { severity = severity }
  end
end

M.on_attach = function(client, bufnr)
  -- diagnostics
  vim.keymap.set("n", "me", "<Cmdglua vim.diagnostic.open_float()<CR>", { buffer = bufnr, desc = "Line Diagnostic" })
  vim.keymap.set("n", "]d", M.diagnostic_goto_next(), { buffer = bufnr, desc = "Next Diagnostic" })
  vim.keymap.set("n", "[d", M.diagnostic_goto_prev(), { buffer = bufnr, desc = "Prev Diagnostic" })
  vim.keymap.set("n", "]e", M.diagnostic_goto_next "ERROR", { buffer = bufnr, desc = "Next Error" })
  vim.keymap.set("n", "[e", M.diagnostic_goto_prev "ERROR", { buffer = bufnr, desc = "Prev Error" })
  vim.keymap.set("n", "]w", M.diagnostic_goto_next "WARN", { buffer = bufnr, desc = "Next Warning" })
  vim.keymap.set("n", "[w", M.diagnostic_goto_prev "WARN", { buffer = bufnr, desc = "Prev Warning" })
  -- LSP
  vim.keymap.set("n", "mh", "<Cmd>lua vim.lsp.buf.hover()<CR>", { buffer = bufnr, desc = "Hover" })
  if client.supports_method "textDocument/signatureHelp" then
    vim.keymap.set("n", "m?", "<Cmd>lua vim.lsp.buf.signature_help()<CR>", { buffer = bufnr, desc = "Signature Help" })
  end
  -- Goto
  if client.supports_method "textDocument/definition" then
    vim.keymap.set("n", "md", function()
      require("telescope.builtin").lsp_definitions()
    end, { buffer = bufnr, desc = "Goto Definition" })
  end
  vim.keymap.set("n", "mD", function()
    require("telescope.builtin").lsp_declarations()
  end, { buffer = bufnr, desc = "Goto Declarations" })
  vim.keymap.set("n", "mI", function()
    require("telescope.builtin").lsp_implementations()
  end, { buffer = bufnr, desc = "Goto Implementations" })
  vim.keymap.set("n", "mt", function()
    require("telescope.builtin").lsp_type_definitions()
  end, { buffer = bufnr, desc = "Goto Type Definitions" })
  vim.keymap.set("n", "mR", "<cmd>Trouble lsp_references<CR>", { buffer = bufnr, desc = "Trouble References" })

  -- Rename
  if client.supports_method "textDocument/rename" then
    vim.keymap.set(
      "n",
      "mr",
      [[<Cmd>IncRename `expand('<cword>')`<CR>]],
      { buffer = bufnr, expr = true, desc = "Rename" }
    )
  end

  -- Code action
  if client.supports_method "textDocument/codeAction" then
    vim.keymap.set("n", "ma", "<Cmd>lua vim.lsp.buf.code_action()<CR>", { buffer = bufnr, desc = "Code Action" })
    vim.keymap.set(
      "v",
      "ma",
      "<Cmd>lua vim.lsp.buf.range_code_action()<CR>",
      { buffer = bufnr, desc = "Code Action (range)" }
    )
  end

  -- Formatting
  if client.supports_method "textDocument/formatting" then
    vim.keymap.set("n", "mf", function()
      require("rc.plugins.lsp.format").format(bufnr)
    end, { buffer = bufnr, desc = "Format Document" })
  end

  if client.supports_method "textDocument/rangeFormatting" then
    vim.keymap.set("v", "mf", function()
      require("rc.plugins.lsp.format").format(bufnr)
    end, { buffer = bufnr, desc = "Format Range" })
  end
end

return M
