return function()
  require("lspconfig").yamlls.setup {
    on_new_config = function(new_config)
      -- lazy load schemastore on demand
      new_config.settings.yaml.schemas = new_config.settings.yaml.schemas or {}
      vim.list_extend(new_config.settings.yaml.schemas, require("schemastore").yaml.schemas())
    end,
    capabilities = require("rc.plugins.lsp.utils").make_client_capabilities(),
    settings = {
      yaml = {
        format = { enable = true },
        validate = { enable = true },
        keyOrdering = false,
      },
    },
  }
end
