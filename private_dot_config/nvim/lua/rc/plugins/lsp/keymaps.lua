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
  -- Lsp server information
  vim.keymap.set("n", "<Space>cl", "<cmd>LspInfo<CR>", { buffer = bufnr, desc = "Lsp Info" })

  -- diagnostics
  vim.keymap.set("n", "<Space>cd", vim.diagnostic.open_float, { buffer = bufnr, desc = "Line Diagnostics" })
  vim.keymap.set("n", "]d", M.diagnostic_goto_next(), { buffer = bufnr, desc = "Next Diagnostic" })
  vim.keymap.set("n", "[d", M.diagnostic_goto_prev(), { buffer = bufnr, desc = "Prev Diagnostic" })
  vim.keymap.set("n", "]e", M.diagnostic_goto_next "ERROR", { buffer = bufnr, desc = "Next Error" })
  vim.keymap.set("n", "[e", M.diagnostic_goto_prev "ERROR", { buffer = bufnr, desc = "Prev Error" })
  vim.keymap.set("n", "]w", M.diagnostic_goto_next "WARN", { buffer = bufnr, desc = "Next Warning" })
  vim.keymap.set("n", "[w", M.diagnostic_goto_prev "WARN", { buffer = bufnr, desc = "Prev Warning" })

  -- Hover
  vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover" })

  -- Signature help
  if client.supports_method "textDocument/signatureHelp" then
    vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "Signature Help" })
    vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "Signature Help" })
  end

  -- Goto
  if client.supports_method "textDocument/definition" then
    vim.keymap.set("n", "gd", function()
      require("telescope.builtin").lsp_definitions()
    end, { buffer = bufnr, desc = "Goto Definition" })
  end

  if client.supports_method "textDocument/declaration" then
    vim.keymap.set("n", "gD", function()
      require("telescope.builtin").lsp_declarations()
    end, { buffer = bufnr, desc = "Goto Declarations" })
  end

  if client.supports_method "textDocument/referenes" then
    vim.keymap.set("n", "gr", function()
      require("telescope.builtin").lsp_references()
    end, { buffer = bufnr, desc = "References" })
  end

  if client.supports_method "textDocument/implementation" then
    vim.keymap.set("n", "gI", function()
      require("telescope.builtin").lsp_implementations()
    end, { buffer = bufnr, desc = "Goto Implementations" })
  end

  if client.supports_method "textDocument/typeDefinition" then
    vim.keymap.set("n", "gy", function()
      require("telescope.builtin").lsp_type_definitions()
    end, { buffer = bufnr, desc = "Goto Type Definitions" })
  end

  -- Rename
  if client.supports_method "textDocument/rename" then
    vim.keymap.set("n", "<Space>cr", function()
      local inc_rename = require "inc_rename"
      return ":" .. inc_rename.config.cmd_name .. " " .. vim.fn.expand "<cword>"
    end, { buffer = bufnr, expr = true, desc = "Rename" })
  end

  -- Code action
  if client.supports_method "textDocument/codeAction" then
    vim.keymap.set({ "n", "v" }, "<Space>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code Action" })
    vim.keymap.set("n", "<Space>cA", function()
      vim.lsp.buf.code_action {
        context = {
          only = { "source" },
        },
        diagnostics = {},
      }
    end, { buffer = bufnr, desc = "Source Action" })
  end

  -- Formatting
  if client.supports_method "textDocument/formatting" then
    vim.keymap.set("n", "<Space>cf", function()
      require("rc.plugins.lsp.format").format(bufnr)
    end, { buffer = bufnr, desc = "Format Document" })
  end

  if client.supports_method "textDocument/rangeFormatting" then
    vim.keymap.set("v", "<Space>cf", function()
      require("rc.plugins.lsp.format").format(bufnr)
    end, { buffer = bufnr, desc = "Format Range" })
  end
end

return M
