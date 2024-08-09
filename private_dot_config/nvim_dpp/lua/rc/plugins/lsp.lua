local M = {}

---@param override lsp.ClientCapabilities?
M.default_capabilities = function(override)
  local if_nil = function(val, default)
    if val == nil then
      return default
    end
    return val
  end
  return {
    textDocument = {
      completion = {
        dynamicRegistration = if_nil(override.dynamicRegistration, false),
        completionItem = {
          snippetSupport = if_nil(override.snippetSupport, true),
          commitCharactersSupport = if_nil(override.commitCharactersSupport, true),
          deprecatedSupport = if_nil(override.deprecatedSupport, true),
          preselectSupport = if_nil(override.preselectSupport, true),
          tagSupport = if_nil(override.tagSupport, {
            valueSet = {
              1, -- Deprecated
            },
          }),
          insertReplaceSupport = if_nil(override.insertReplaceSupport, true),
          resolveSupport = if_nil(override.resolveSupport, {
            properties = {
              "documentation",
              "detail",
              "additionalTextEdits",
              "sortText",
              "filterText",
              "insertText",
              "textEdit",
              "insertTextFormat",
              "insertTextMode",
            },
          }),
          insertTextModeSupport = if_nil(override.insertTextModeSupport, {
            valueSet = {
              1, -- asIs
              2, -- adjustIndentation
            },
          }),
          labelDetailsSupport = if_nil(override.labelDetailsSupport, true),
        },
        contextSupport = if_nil(override.snippetSupport, true),
        insertTextMode = if_nil(override.insertTextMode, 1),
        completionList = if_nil(override.completionList, {
          itemDefaults = {
            "commitCharacters",
            "editRange",
            "insertTextFormat",
            "insertTextMode",
            "data",
          },
        }),
      },
    },
  }
end

M.setup_diagnostic = function()
  -- Global diagnostic configurations

  -- diagnostic signs
  for name, icon in pairs(require("rc.settings").icons.diagnostics) do
    local hl = "DiagnosticSign" .. name
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
  end

  -- options for vim.diagnostic.config()
  local opts = {
    underline = true,
    virtual_text = {
      source = "always",
      prefix = vim.fn.has "nvim-0.10.0" == 0 and "●" or function(diagnostic)
        local icons = require("rc.core.config").icons.diagnostics
        for d, icon in pairs(icons) do
          if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
            return icon
          end
        end
      end,
    },
    virtual_lines = {
      only_current_line = true,
    },
    signs = {
      priority = 20,
    },
    float = {
      source = "always",
      border = "single",
    },
    update_in_insert = false,
    severity_sort = true,
  }

  vim.diagnostic.config(opts.diagnostics)
end

--@param string?  severity for vim.diagnostics
M.diagnostic_goto_next = function(severity_key)
  local severity = severity_key and vim.diagnostic.severity[severity_key] or nil
  return function()
    vim.diagnostic.goto_next { severity = severity }
  end
end

--@param string?  severity for vim.diagnostics
M.diagnostic_goto_prev = function(severity_key)
  local severity = severity_key and vim.diagnostic.severity[severity_key] or nil
  return function()
    vim.diagnostic.goto_prev { severity = severity }
  end
end

M.setup_keymap = function(client, bufnr)
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

M.setup_codelens = function(client, bufnr)
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

M.setup_document_highlight = function(client, bufnr)
  if client.supports_method "textDocument/documentHighlight" then
    local group = vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = true })
    vim.api.nvim_clear_autocmds { group = group, buffer = bufnr }
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

M.setup_inlay_hint = function(client, bufnr)
  if client.supports_method "textDocument/inlayHint" then
    vim.lsp.inlay_hint.enable(bufnr, true)
    local group = vim.api.nvim_create_augroup("LspInlayHint", { clear = true })
    vim.api.nvim_create_autocmd({ "InsertEnter" }, {
      group = group,
      buffer = bufnr,
      callback = function()
        vim.lsp.inlay_hint.enable(bufnr, false)
      end,
    })
    vim.api.nvim_create_autocmd({ "InsertLeave" }, {
      group = group,
      buffer = bufnr,
      callback = function()
        vim.lsp.inlay_hint.enable(bufnr, true)
      end,
    })
  end
end

return M
