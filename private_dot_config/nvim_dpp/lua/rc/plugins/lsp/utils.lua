local M = {}

-- Refer:
-- https://github.com/ryoppippi/dotfiles/blob/e6e0f02/nvim/lua/plugin/nvim-lspconfig/utils.lua

M.ft = {}
M.ft.js_like = {
  "javascript",
  "javascriptreact",
  "javascript.jsx",
  "typescript",
  "typescriptreact",
  "typescript.tsx",
}

M.ft.js_framework_like = {
  unpack(M.ft.js_like),
  "svelte",
  "astro",
  "vue",
}

M.ft.markdown_like = {
  "markdown",
  "markdown.mdx",
}

M.ft.css_like = {
  "css",
  "scss",
  "less",
}

M.ft.html_like = {
  unpack(M.ft.markdown_like),
  unpack(M.ft.css_like),
  unpack(M.ft.js_framework_like),
  "html",
  "htmldjango",
}

M.ft.json_like = {
  "json",
  "jsonc",
  "json5",
}

M.ft.yaml_like = {
  "yaml",
  "yaml.docker-compose",
  "yaml.gitlab",
}

M.ft.sh_like = {
  "sh",
  "bash",
  "zsh",
  "fish",
}

M.ft.deno_files = {
  "deno.json",
  "deno.jsonc",
  "denops",
  "package.json",
}

M.ft.node_specific_files = {
  "node_modules",
  "bun.lockb", -- bun
  "package-lock.json", -- npm or bun
  "npm-shrinkwrap.json", -- npm
  "yarn.lock", -- yarn
  "pnpm-lock.yaml", -- pnpm
}

M.ft.node_files = {
  unpack(M.ft.node_specific_files),
  "package.json",
}

-- Taken from ddc-source-lsp
---@param override? table
---@return table client_capabilitiesu
M.make_client_capabilities = function(override)
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion = {
    dynamicRegistration = false,
    completionItem = {
      snippetSupport = true,
      commitCharactersSupport = true,
      deprecatedSupport = true,
      preselectSupport = true,
      tagSupport = {
        valueSet = {
          1, -- Deprecated
        },
      },
      insertReplaceSupport = true,
      resolveSupport = {
        properties = {
          "documentation",
          "detail",
          "additionalTextEdits",
          "insertText",
          -- "sortText",
          -- "filterText",
          "textEdit",
          "insertTextFormat",
          "insertTextMode",
        },
      },
      insertTextModeSupport = {
        valueSet = {
          1, -- asIs
          2, -- adjustIndentation
        },
      },
      labelDetailsSupport = true,
    },
    contextSupport = true,
    insertTextMode = 1,
    completionList = {
      itemDefaults = {
        "commitCharacters",
        "editRange",
        "insertTextFormat",
        "insertTextMode",
        "data",
      },
    },
  }
  capabilities = vim.tbl_deep_extend("force", capabilities, override or {})
  return capabilities
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
    vim.diagnostic.jump { count = 1, float = true, severity = severity }
  end
end

--@param string?  severity for vim.diagnostics
M.diagnostic_goto_prev = function(severity_key)
  local severity = severity_key and vim.diagnostic.severity[severity_key] or nil
  return function()
    vim.diagnostic.jump { count = -1, float = true, severity = severity }
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
          diagnostics = {},
        },
      }
    end, { buffer = bufnr, desc = "Source Action" })
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
    local filter = { bufnr = bufnr }
    if vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].buftype == "" then
      vim.lsp.inlay_hint.enable(true, filter)
      local group = vim.api.nvim_create_augroup("LspInlayHint", { clear = true })
      vim.api.nvim_create_autocmd({ "InsertEnter" }, {
        group = group,
        buffer = bufnr,
        callback = function()
          vim.lsp.inlay_hint.enable(false, filter)
        end,
      })
      vim.api.nvim_create_autocmd({ "InsertLeave" }, {
        group = group,
        buffer = bufnr,
        callback = function()
          vim.lsp.inlay_hint.enable(true, filter)
        end,
      })
    end
  end
end

return M
