local M = {}

M.on_attach = function(client, bufnr)
  -- diagnostics
  vim.keymap.set("n", "me", "<Cmdglua vim.diagnostic.open_float()<CR>", { buffer = bufnr, desc = "Line Diagnostic" })
  vim.keymap.set("n", "m[", "<Cmd>lua vim.diagnostic.goto_prev()<CR>", { buffer = bufnr, desc = "Prev Diagnostic" })
  vim.keymap.set("n", "m]", "<Cmd>lua vim.diagnostic.goto_next()<CR>", { buffer = bufnr, desc = "Next Diagnostic" })
  -- LSP
  vim.keymap.set("n", "mh", "<Cmd>lua vim.lsp.buf.hover()<CR>", { buffer = bufnr, desc = "Hover" })
  vim.keymap.set("n", "m?", "<Cmd>lua vim.lsp.buf.signature_help()<CR>", { buffer = bufnr, desc = "Signature Help" })
  -- Goto
  vim.keymap.set("n", "md", function()
    require("telescope.builtin").lsp_definitions()
  end, { buffer = bufnr, desc = "Goto Definition" })
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
      require("rc.plugins.lsp.formatting").format(bufnr)
    end, { buffer = bufnr, desc = "Format Document" })
  end

  if client.supports_method "textDocument/rangeFormatting" then
    vim.keymap.set("v", "mf", function()
      require("rc.plugins.lsp.formatting").format(bufnr)
    end, { buffer = bufnr, desc = "Format Range" })
  end
end

return M
