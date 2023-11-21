local M = {
  "neovim/nvim-lspconfig",
  name = "lsp",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
    { "folke/neodev.nvim", config = true },
    "mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    -- for setting
    {
      "hrsh7th/cmp-nvim-lsp",
    },
    -- better renaem
    {
      "smjonas/inc-rename.nvim",
      cmd = { "IncRename" },
      config = true,
    },
  },
  ---@class PluginLspOpts
  opts = {
    -- options for vim.diagnostic.config()
    diagnostics = {
      underline = true,
      virtual_text = {
        source = "always",
        prefix = "icons",
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
    },
    -- Add any global capabilities here
    capabilities = {},
    -- LSP server settings
    ---@type lspconfig.options
    servers = {
      bashls = {},
      cmake = {},
      cssls = {},
      fortls = {},
      html = {},
      jsonls = {},
      lua_ls = {
        single_file_support = true,
        settings = {
          Lua = {
            completion = {
              workspaceWord = true,
              callSnippet = "Replace",
            },
            misc = {
              parameters = {
                "--log-level=trace",
              },
            },
            format = {
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
  },
  ---@param opts PluginLspOpts
  config = function(_, opts)
    -- Events executed on attach server
    vim.api.nvim_create_autocmd({ "LspAttach" }, {
      group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
      callback = function(ev)
        local bufnr = ev.buf
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        require("rc.plugins.lsp.codelens").on_attach(client, bufnr)
        -- require("rc.plugins.lsp.format").on_attach(client, bufnr)
        require("rc.plugins.lsp.highlight").on_attach(client, bufnr)
        require("rc.plugins.lsp.keymaps").on_attach(client, bufnr)
      end,
      desc = "[LSP] on attach server",
    })

    -- Configure diagnostics
    require("rc.plugins.lsp").setup_diagnostics(opts.diagnostics)

    -- Server setup
    local servers = opts.servers
    local default_capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      require("cmp_nvim_lsp").default_capabilities()
    )

    local setup = function(server_name)
      local server_opts = vim.tbl_deep_extend("force", {
        capabilities = vim.deepcopy(default_capabilities),
      }, servers[server_name] or {})
      if opts.setup[server_name] then
        if opts.setup[server_name](server_name, server_opts) then
          return
        end
      elseif opts.setup["*"] then
        if opts.setup["*"](server_name, server_opts) then
          return
        end
      end
      return require("lspconfig")[server_name].setup(server_opts)
    end

    local all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
    local ensure_installed = {} ---@type string[]
    for server_name, server_opts in pairs(servers) do
      if server_opts then
        server_opts = server_opts == true and {} or server_opts
        -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
        if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server_name) then
          setup(server_name)
        else
          ensure_installed[#ensure_installed + 1] = server_name
        end
      end
    end

    require("mason-lspconfig").setup {
      ensure_installed = ensure_installed,
      handlers = { setup },
    }
  end,
}

---@param opts table options for vim.diagnostic.config()
M.setup_diagnostics = function(opts)
  for name, icon in pairs(require("rc.core.config").icons.diagnostics) do
    local hl = "DiagnosticSign" .. name
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
  end

  opts = opts and opts or {}
  if opts.virtual_text.prefix == "icons" then
    opts.virtual_text.prefix = vim.fn.has "nvim-0.10.0" == 0 and "●"
      or function(diagnostic)
        local icons = require("rc.core.config").icons.diagnostics
        for d, icon in pairs(icons) do
          if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
            return icon
          end
        end
      end
  end

  vim.diagnostic.config(opts.diagnostics)
end

return M
