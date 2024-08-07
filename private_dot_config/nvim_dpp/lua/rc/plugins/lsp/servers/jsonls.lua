return function()
  require("lspconfig").jsonls.setup {
    on_new_config = function(new_config)
      -- lazy load schemastore on demand
      new_config.settings.json.schemas = new_config.settings.json.schemas or {}
      vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
    end,
    capabilities = require("rc.plugins.lsp.utils").make_client_capabilities(),
    settings = {
      json = {
        format = { enable = true },
        validate = { enable = true },
      },
    },
  }
end
