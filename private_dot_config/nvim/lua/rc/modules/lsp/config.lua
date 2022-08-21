local M = {}

-- Configure mason-lspconfig
M.mason_lspconfig = {
  config = function()
    local mason_lspconfig = require("mason-lspconfig")
    local common_opts = require("rc.modules.lsp.utils").get_common_opts()

    mason_lspconfig.setup {
      ensure_installed = {
        "bashls",
        "clangd",
        "cmake",
        "cssls",
        "denols",
        "fortls",
        "html",
        "jsonls",
        "pyright",
        "rust_analyzer",
        "sumneko_lua",
        "texlab",
        "vimls",
        "yamlls",
      },
    }

    mason_lspconfig.setup_handlers {
      -- the default handler
      function(server_name)
        require("lspconfig")[server_name].setup(common_opts)
      end,
      -- targetted overrides for specific servers
      ["clangd"] = function()
        local server_settings = {
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
        }
        local server = vim.tbl_deep_extend("force", {}, common_opts, server_settings)
        require("clangd_extensions").setup {
          server = server,
        }
      end,
      ["sumneko_lua"] = function()
        local server_settings = {
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
              },
              telemetry = {
                enable = false,
              },
            },
          },
        }
        local lspconfig = vim.tbl_deep_extend("force", {}, common_opts, server_settings)
        local luadev = require("lua-dev").setup {
          lspconfig = lspconfig,
        }
        require("lspconfig").sumneko_lua.setup(luadev)
      end,
      ["rust_analyzer"] = function()
        local server_settings = {
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
        }
        local server = vim.tbl_deep_extend("force", {}, common_opts, server_settings)
        require("rust-tools").setup {
          server = server,
        }
      end,
    }
  end,
}

-- Configure nvim-lspconfig
M.nvim_lspconfig = {
  config = function()
    -- Change diagnostic symbols in the sign column (gutter)
    local signs = { Error = "", Warning = "", Info = "", Hint = "" }

    for type, icon in pairs(signs) do
      local hl = "LspDiagnosticsSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    -- Diagnostic config
    vim.diagnostic.config {
      underline = true,
      virtual_text = {
        source = "always",
      },
      signs = {
        priority = 20,
      },
      float = {
        source = "always",
        border = "single",
      }, update_in_insert = false,
      severity_sort = true,
    }

    -- Set handlers
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
      vim.lsp.handlers.signature_help, {
      border = "single"
    })
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
      vim.lsp.handlers.hover, {
      border = "single"
    })
  end
}

-- Configure null-ls
M.null_ls = {
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup {
      debounce = 150,
      save_after_format = false, -- toggle manually
      sources = {
        null_ls.builtins.code_actions.gitsigns,
        null_ls.builtins.code_actions.shellcheck,
        null_ls.builtins.diagnostics.markdownlint,
        null_ls.builtins.diagnostics.shellcheck,
        null_ls.builtins.diagnostics.vint,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.cmake_format,
        null_ls.builtins.formatting.fixjson.with {
          filetypes = { "jsonc" },
        },
        null_ls.builtins.formatting.prettierd,
        null_ls.builtins.formatting.shfmt.with {
          args = { "-ln", "bash", "-i", "2", "-bn", "-ci", "-sr", "-kp" },
        },
        -- null_ls.builtins.formatting.stylua,
      },
      on_attach = require("rc.modules.lsp.utils").common_on_attach,
    }
  end,
}

return M
