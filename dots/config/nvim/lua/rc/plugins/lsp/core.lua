---@diagnostic disable: missing-fields
return {
  "neovim/nvim-lspconfig",
  lazy = false,
  opts_extend = { "servers.*.keys" },
  opts = function()
    local diagnostic_icons = require("rc.core.config").icons.diagnostics
    ---@class PluginLspOpts
    local ret = {
      -- options for vim.diagnostic.config()
      ---@type vim.diagnostic.Opts
      diagnostics = {
        underline = true,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "icons",
        },
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = diagnostic_icons.Error,
            [vim.diagnostic.severity.WARN] = diagnostic_icons.Warn,
            [vim.diagnostic.severity.HINT] = diagnostic_icons.Hint,
            [vim.diagnostic.severity.INFO] = diagnostic_icons.Info,
          },
        },
        float = {
          source = "if_many",
          border = "single",
        },
        update_in_insert = false,
      },
      -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
      inlay_hints = {
        enabled = true,
        -- filetypes for which you don't want to enable inlay hints
        exclude = { "vue" },
      },
      -- Enable this to enable the builtin LSP code lenses on Neovim >= 0.10.0
      codelens = {
        enabled = false,
      },
      -- Enable this to enable the builtin LSP folding on Neovim.
      folds = {
        enabled = true,
      },
      -- LSP Server Settings
      ---@type table<string, vim.lsp.ClientConfig>
      servers = {
        -- Configurations common to all LSP servers
        ["*"] = {
          ---@type lsp.ClientCapabilities
          capabilities = {
            workspace = {
              didChangeWatchedFiles = {
                dynamicRegistration = false,
              },
              fileOperations = {
                didRename = true,
                willRename = true,
              },
            },
          },
          keys = {
            { "<Space>cl", "<cmd>LspInfo<CR>", desc = "Lsp Info" },
            { "gd", vim.lsp.buf.definition, desc = "Goto Definition", has = "definition" },
            { "gr", vim.lsp.buf.references, desc = "Goto References", nowait = true, has = "references" },
            { "gI", vim.lsp.buf.implementation, desc = "Goto Implementation", has = "implementation" },
            { "gy", vim.lsp.buf.type_definition, desc = "Goto Type Defintiion", has = "typeDefinition" },
            { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration", has = "declaration" },
            {
              "K",
              function()
                return vim.lsp.buf.hover()
              end,
              desc = "Hover",
            },
            {
              "gK",
              function()
                return vim.lsp.buf.signature_help()
              end,
              desc = "Signature Help",
              has = "signatureHelp",
            },
            {
              "<C-k>",
              function()
                return vim.lsp.buf.signature_help()
              end,
              mode = { "i" },
              desc = "Signature Help",
              has = "signatureHelp",
            },
            {
              "<Space>ca",
              vim.lsp.buf.code_action,
              mode = { "n", "v" },
              desc = "Code Action",
              has = "codeAction",
            },
            { "<Space>cr", vim.lsp.buf.rename, desc = "Rename", has = "rename" },
            {
              "<Space>cR",
              function()
                Snacks.rename.rename_file()
              end,
              desc = "Rename File",
              has = { "workspace/didRenameFiles", "workspace/willRenameFiles" },
            },
            {
              "<Space>cc",
              vim.lsp.codelens.run,
              mode = { "n", "v" },
              desc = "CodeLens",
              has = "codeLens",
            },
            {
              "<Space>cC",
              vim.lsp.codelens.refresh,
              desc = "Refresh & Display CodeLens",
              mode = { "n" },
              has = "codeLens",
            },
            {
              "<Space>cA",
              require("rc.utils.lsp").action.source,
              desc = "Source Action",
              has = "codeAction",
            },
            {
              "]]",
              function()
                Snacks.words.jump(vim.v.count1)
              end,
              desc = "Next Reference",
              has = "documentHighlight",
              cond = function()
                return Snacks.words.is_enabled()
              end,
            },
            {
              "[[",
              function()
                Snacks.words.jump(-vim.v.count1)
              end,
              desc = "Prev Reference",
              has = "documentHighlight",
              cond = function()
                return Snacks.words.is_enabled()
              end,
            },
            {
              "<M-n>",
              function()
                Snacks.words.jump(vim.v.count1, true)
              end,
              desc = "Next Reference",
              has = "documentHighlight",
              cond = function()
                return Snacks.words.is_enabled()
              end,
            },
            {
              "<M-p>",
              function()
                Snacks.words.jump(-vim.v.count1, true)
              end,
              desc = "Prev Reference",
              has = "documentHighlight",
              cond = function()
                return Snacks.words.is_enabled()
              end,
            },
          },
        },
        -- disable stylua from nvim-lspconfig
        stylua = { enabled = false },
        -- Lua language server
        lua_ls = {
          settings = {
            Lua = {
              runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                pathStrict = true,
                version = "LuaJIT",
                path = { "?.lua", "?/init.lua" },
              },
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                callSnippet = "Both",
                enable = true,
                keywordSnippet = "Both",
              },
              doc = {
                privateName = { "^_" },
              },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
              },
            },
          },
        },
      },
    }
    return ret
  end,

  ---@param opts PluginLspOpts
  config = function(_, opts)
    local lsp_utils = require "rc.utils.lsp"

    -- setup keymaps
    for server, server_opts in pairs(opts.servers) do
      if type(server_opts) == "table" and server_opts.keys then
        require("rc.plugins.lsp.keymaps").set({ name = server ~= "*" and server or nil }, server_opts.keys)
      end
    end

    -- inlay hints
    if opts.inlay_hints.enabled then
      Snacks.util.lsp.on({ method = "textDocument/inlayHint" }, function(buffer)
        if
          vim.api.nvim_buf_is_valid(buffer)
          and vim.bo[buffer].buftype == ""
          and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[buffer].filetype)
        then
          vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
        end
      end)
    end

    -- code lens
    if opts.codelens.enabled and vim.lsp.codelens then
      Snacks.util.lsp.on({ method = "textDocument/codeLens" }, function(buffer)
        vim.lsp.codelens.refresh()
        vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
          buffer = buffer,
          callback = vim.lsp.codelens.refresh,
        })
      end)
    end

    -- diagnostics
    if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
      opts.diagnostics.virtual_text.prefix = function(diagnostic)
        local icons = require("rc.core.config").icons.diagnostics
        for d, icon in pairs(icons) do
          if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
            return icon
          end
        end
        return "●"
      end
    end

    vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

    if opts.servers["*"] then
      vim.lsp.config("*", opts.servers["*"])
    end

    -- config servers
    for server, server_opts in pairs(opts.servers) do
      if server ~= "*" then
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          if server_opts.enabled ~= false then
            vim.lsp.config(server, server_opts)
            vim.lsp.enable(server)
          end
        end
      end
    end
  end,
}
