local lspconfig = require "lspconfig"

-- Customize UI
require "rc.config.lsp.diagnostics"
require("rc.config.lsp.kind").setup()
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" })
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })

-- Setup LSP server installer
require "rc.config.lsp.installer"

-- Custom on_init callback
local function on_init(client)
  client.config.flags = client.config.flags or {}
  client.config.flags.allow_incremental_sync = true
end

-- Custom on_attach callback
local function on_attach(client, bufnr)
  require("rc.config.lsp.formatting").setup(client, bufnr)
  require("rc.config.lsp.keymap").setup(client, bufnr)
  require("rc.config.lsp.highlight").setup(client, bufnr)
  require("rc.config.lsp.code_lens").setup(client, bufnr)
end

-- Capabilities (for nvim-cmp)
local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
local completionItem = updated_capabilities.textDocument.completion.completionItem
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

-- default options for all servers
local default_options = {
  on_init = on_init,
  on_attach = on_attach,
  capabilities = updated_capabilities,
  flags = {
    debounce_text_changes = nil,
  },
}

--[[ LSP servers ]]
-- list of LSP servers associated with enhanced server options
local servers = {
  -- https://github.com/bash-lsp/bash-language-server
  bashls = {
    filetypes = { "sh", "bash", "zsh" },
  },
  -- https://github.com/regen100/cmake-language-server
  cmake = {},
  -- https://github.com/vscode-langservers/vscode-css-languageserver-bin
  cssls = {
    cmd = { "css-languageserver", "--stdio" },
    filetypes = { "css", "scss", "less", "sass" },
    root_dir = lspconfig.util.root_pattern("package.json", ".git"),
  },
  -- https://github.com/hansec/fortran-language-server
  fortls = {},
  -- https://github.com/golang/tools/tree/master/gopls
  gopls = {
    cmd = { "gopls", "--remote=auto" },
    settings = {
      hoverKind = "SynopsisDocumentation",
      matcher = "fuzzy",
      deepCompletion = true,
      usePlaceholders = true,
    },
  },
  -- https://github.com/vscode-langservers/vscode-html-languageserver-bin
  html = {
    cmd = { "html-languageserver", "--stdio" },
  },
  -- https://github.com/vscode-langservers/vscode-json-languageserver
  jsonls = {
    cmd = { "vscode-json-languageserver", "--stdio" },
  },
  -- https://github.com/microsoft/pyright
  pyright = {
    settings = {
      python = { formatting = { provider = "black" } },
    },
  },
  -- https://solargraph.org/
  solargraph = {},
  -- https://github.com/sumneko/lua-language-server
  sumneko_lua = {
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
          path = vim.split(package.path, ";"),
        },
        diagnostics = {
          globals = { "vim", "packer_plugins" },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
          -- library = {
          --   [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          --   [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
          -- },
        },
        telemetry = {
          enable = false,
        },
      },
    },
  },
  -- https://github.com/iamcco/vim-language-server vimls = {},
  vimls = {},
  -- https://github.com/redhat-developer/yaml-language-server
  yamlls = {},
}

-- setup null-ls (https://github.com/jose-elias-alvarez/null-ls.nvim)
require("rc.config.lsp.null-ls").setup(default_options)
-- setup clangd
require("clangd_extensions").setup {
  server = {
    cmd = {
      "clangd",
      "--background-index",
      "--clang-tidy",
      "--header-insertion=iwyu",
      "--suggest-missing-includes",
      "--all-scope-completion",
      "--completion-style=detailed",
      "--cross-file-rename",
    },
    init_options = {
      clangdFileStatus = true,
      usePlaceholders = true,
      completeUnimported = true,
    },
  },
}
-- setup rust_analyzer
require("rust-tools").setup {
  server = {
    settings = {
      ["rust-analyzer"] = {
        assist = {
          importGranularity = "module",
          importPrefix = "by_self",
        },
        cargo = {
          loadOutDirsFromCheck = true,
        },
        procMacro = {
          enable = true,
        },
      },
    },
  },
}
-- setup other LSP servers
for server_name, options in pairs(servers) do
  local server_config = vim.tbl_deep_extend("force", default_options, options)
  lspconfig[server_name].setup(server_config)
end
