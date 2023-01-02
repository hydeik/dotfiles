local M = {
  "neovim/nvim-lspconfig",
  name = "lsp",
  event = "BufReadPre",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "williamboman/mason-lspconfig.nvim",
    -- "simrat39/rust-tools.nvim",
    -- "p00f/clangd_extensions.nvim",
    "folke/neodev.nvim",
    "jose-elias-alvarez/typescript.nvim",
    "b0o/SchemaStore.nvim",
  },
}

M.config = function()
  require("rc.plugins.lsp.diagnostics").setup()

  require "mason"
  require("neodev").setup()

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }

  local on_attach = function(client, bufnr)
    if client.supports_method "textDocument/documentSymbol" then
      require("nvim-navic").attach(client, bufnr)
    end
    require("rc.plugins.lsp.codelens").on_attach(client, bufnr)
    require("rc.plugins.lsp.formatting").on_attach(client, bufnr)
    require("rc.plugins.lsp.highlight").on_attach(client, bufnr)
    require("rc.plugins.lsp.mappings").on_attach(client, bufnr)
  end

  local servers = {
    bashls = {},
    cmake = {},
    cssls = {},
    fortls = {},
    html = {},
    jsonls = {
      settings = {
        json = {
          format = { enable = true },
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      },
    },
    pyright = {},
    sumneko_lua = {
      single_file_support = true,
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
            path = vim.split(package.path, ";"),
          },
          workspace = {
            checkThirdParty = false,
            library = vim.api.nvim_get_runtime_file("", true),
          },
          completion = {
            workspaceWord = true,
            callSnippet = "Both",
          },
          misc = {
            parameters = {
              "--log-level=trace",
            },
          },
          diagnostics = {
            globals = { "vim" },
            unusedLocalExclude = { "_*" },
          },
          format = {
            enable = false,
          },
          telemetry = {
            enable = false,
          },
        },
      },
    },
    teal_ls = {},
    texlab = {},
    tsserver = {},
    vimls = {},
    yamlls = {},
  }

  local options = {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    },
  }

  for server, opts in pairs(servers) do
    opts = vim.tbl_deep_extend("force", {}, options, opts or {})
    if server == "tsserver" then
      require("typescript").setup { server = opts }
    else
      require("lspconfig")[server].setup(opts)
    end
  end

  require("rc.plugins.null-ls").setup(options)
end

return M
