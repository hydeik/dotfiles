local M = {}

-- [[ Formatting ]]
M.null_ls_has_formatter = function(ft)
  local status, sources = pcall(require, "null-ls.sources")
  if status then
    local available = sources.get_available(ft, "NULL_LS_FORMATTING")
    return #available > 0
  else
    return false
  end
end

M.lsp_formatting = function(bufnr)
  -- Use the formatters provided by the null-ls when available.
  -- Otherwise, use the formatter provided by other LSP client(s)
  local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
  local use_null_ls = M.null_ls_has_formatter(ft)
  vim.lsp.buf.format({
    filter = function(client)
      local enable = false
      if use_null_ls then
        enable = client.name == "null-ls"
      else
        enable = not (client.name == "null-ls")
      end
      return enable
    end,
    bufnr = bufnr,
  })
end

M.autocmd_format_on_save = function(client, bufnr)
  if client.supports_method("textDocument/formatting") then
    local augroup_formatting = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
    vim.api.nvim_clear_autocmds({ group = augroup_formatting, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup_formatting,
      buffer = bufnr,
      callback = function()
        require("rc.modules.lsp.utils").lsp_formatting(bufnr)
      end,
    })
  end
end

-- [[ Document Highlights ]]
M.autocmd_document_highlight = function(client, bufnr)
  if client.supports_method("textDocument/documentHighlight") then
    local group = vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = true })
    vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })
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

-- [[ Core Lens ]]
M.autocmd_codelens_refresh = function(client, bufnr)
  if client.supports_method("textDocument/codeLens") then
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

-- Key mappings
M.define_keymaps = function(client, bufnr)
  -- diagnostics
  vim.keymap.set("n", "me", "<Cmd>lua vim.diagnostic.open_float()<CR>", { buffer = bufnr })
  vim.keymap.set("n", "m[", "<Cmd>lua vim.diagnostic.goto_prev()<CR>", { buffer = bufnr })
  vim.keymap.set("n", "m]", "<Cmd>lua vim.diagnostic.goto_next()<CR>", { buffer = bufnr })
  -- LSP
  vim.keymap.set("n", "md", "<Cmd>lua vim.lsp.buf.definition()<CR>", { buffer = bufnr })
  vim.keymap.set("n", "mh", "<Cmd>lua vim.lsp.buf.hover()<CR>", { buffer = bufnr })
  vim.keymap.set("n", "mR", "<Cmd>lua vim.lsp.buf.rename()<CR>", { buffer = bufnr })
  vim.keymap.set("n", "m?", "<Cmd>lua vim.lsp.buf.signature_help()<CR>", { buffer = bufnr })
  vim.keymap.set("n", "mD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", { buffer = bufnr })
  vim.keymap.set("n", "mi", "<Cmd>lua vim.lsp.buf.type_definition()<CR>", { buffer = bufnr })
  vim.keymap.set("n", "mr", "<Cmd>lua vim.lsp.buf.references()<CR>", { buffer = bufnr })
  -- vim.keymap.set("n", "mo", "<Cmd>lua vim.lsp.buf.document_symbol()<CR>", { buffer = bufnr })

  if client.supports_method("textDocument/codeAction") then
    vim.keymap.set("n", "ma", "<Cmd>lua vim.lsp.buf.code_action()<CR>", { buffer = bufnr, desc = "Code Action" })
    vim.keymap.set("v", "ma", "<Cmd>lua vim.lsp.buf.range_code_action()<CR>",
      { buffer = bufnr, desc = "Code Action (range)" })
  end

  if client.supports_method("textDocument/formatting") then
    vim.keymap.set("n", "mF", function()
      require("rc.modules.lsp.utils").lsp_formatting(bufnr)
    end, { buffer = bufnr, desc = "Format buffer" })
  end

  -- if client.supports_method("textDocument/rangeFormatting") then
  --   vim.keymap.set("n", "m=", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", { buffer = bufnr })
  -- end
end

-- Return custom capabilities
M.common_capabilities = function()
  -- Capabilities (for nvim-cmp)
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local completionItem = capabilities.textDocument.completion.completionItem
  completionItem.documentationFormat = { "markdown" }
  completionItem.snippetSupport = true
  completionItem.preselectSupport = true
  completionItem.insertReplaceSupport = true
  completionItem.labelDetailsSupport = true
  completionItem.deprecatedSupport = true
  completionItem.commitCharactersSupport = true
  completionItem.tagSupport = { valueSet = { 1 } }
  completionItem.resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  }
  return capabilities
end

-- A callback function called on initializing a LSP client.
M.common_on_init = function(_, _) end

-- A callback function called on exitting a LSP client.
M.common_on_exit = function(_, _) end

-- A callback function called on attaching a LSP client to a buffer.
M.common_on_attach = function(client, bufnr)
  local utils = require("rc.modules.lsp.utils")
  utils.define_keymaps(client, bufnr)
  utils.autocmd_format_on_save(client, bufnr)
  utils.autocmd_document_highlight(client, bufnr)
  utils.autocmd_codelens_refresh(client, bufnr)

  if client.supports_method("textDocument/documentSymbol") then
    local ok, navic = pcall(require, "nvim-navic")
    if ok then
      navic.attach(client, bufnr)
    end
  end
end

-- Returns common options to be passed to a LSP client
M.get_common_opts = function()
  local utils = require("rc.modules.lsp.utils")
  return {
    on_attach = utils.common_on_attach,
    on_init = utils.common_on_init,
    on_exit = utils.common_on_exit,
    capabilities = utils.common_capabilities(),
  }
end

return M
