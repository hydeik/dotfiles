return {
  "neovim/nvim-lspconfig",
  lazy = true,
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
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
      -- Be aware that you also will need to properly configure your LSP server to
      -- provide the inlay hints.
      inlay_hints = {
        enabled = true,
        -- filetypes for which you don't want to enable inlay hints
        exclude = { "vue" },
      },
      -- Enable this to enable the builtin LSP code lenses on Neovim >= 0.10.0
      -- Be aware that you also will need to properly configure your LSP server to
      -- provide the code lenses.
      codelens = {
        enabled = false,
      },
      -- Add any global capabilities here
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
      -- LSP Server Settings
      ---@type lspconfig.options
      servers = {
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
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- example to setup with typescript.nvim
        -- tsserver = function(_, opts)
        --   require("typescript").setup({ server = opts })
        --   return true
        -- end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    }
    return ret
  end,

  ---@param opts PluginLspOpts
  config = function(_, opts)
    local lsp_utils = require "rc.utils.lsp"
    -- setup keymaps
    lsp_utils.on_attach(function(client, buffer)
      require("rc.plugins.lsp.keymaps").on_attach(client, buffer)
    end)

    lsp_utils.setup()
    lsp_utils.on_dynamic_capability(require("rc.plugins.lsp.keymaps").on_attach)

    -- virtual text
    if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
      opts.diagnostics.virtual_text.prefix = vim.fn.has "nvim-0.10.0" == 0 and "●"
        or function(diagnostic)
          local icons = require("rc.core.config").icons.diagnostics
          for d, icon in pairs(icons) do
            if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
              return icon
            end
          end
        end
    end

    vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

    -- inlay hints
    if opts.inlay_hints.enabled then
      lsp_utils.on_supports_method("textDocument/inlayHint", function(_, buffer)
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
      lsp_utils.on_supports_method("textDocument/codeLens", function(_, buffer)
        vim.lsp.codelens.refresh()
        vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
          buffer = buffer,
          callback = vim.lsp.codelens.refresh,
        })
      end)
    end

    -- server settings
    local servers = opts.servers
    local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    local has_blink, blink = pcall(require, "blink.cmp")
    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      has_cmp and cmp_nvim_lsp.default_capabilities() or {},
      has_blink and blink.get_lsp_capabilities() or {},
      opts.capabilities or {}
    )

    local setup = function(server)
      local server_opts = vim.tbl_deep_extend("force", {
        capabilities = vim.deepcopy(capabilities),
      }, servers[server] or {})
      if server_opts.enabled == false then
        return
      end

      if opts.setup[server] then
        -- specific server configuration
        if opts.setup[server](server, server_opts) then
          return
        end
      elseif opts.setup["*"] then
        if opts.setup["*"](server, server_opts) then
          return
        end
      end

      require("lspconfig")[server].setup(server_opts)
    end

    for server, server_opts in pairs(servers) do
      if server_opts then
        server_opts = server_opts == true and {} or server_opts
        if server_opts.enabled ~= false then
          setup(server)
        end
      end
    end

    -- Avoid conflicts of LSPs
    if lsp_utils.is_enabled "denols" and lsp_utils.is_enabled "vtsls" then
      local is_deno = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc")
      lsp_utils.disable("vtsls", is_deno)
      lsp_utils.disable("denols", function(root_dir, config)
        if not is_deno(root_dir) then
          config.settings.deno.enable = false
        end
        return false
      end)
    end
  end,
}
