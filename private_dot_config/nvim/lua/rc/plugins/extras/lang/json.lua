return {
  "neovim/nvim-lspconfig",
  dependencies = {
    {
      "b0o/SchemaStore.nvim",
      version = false, -- last release is way too old
    },
  },
  opts = {
    servers = {
      jsonls = {
        on_new_config = function(new_config)
          -- lazy load schemastore on demand
          new_config.settings.json.schemas = new_config.settings.json.schemas or {}
          vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
        end,
        settings = {
          json = {
            format = { enable = true },
            validate = { enable = true },
          },
        },
      },
      yamlls = {
        on_new_config = function(new_config)
          -- lazy load schemastore on demand
          new_config.settings.yaml.schemas = new_config.settings.yaml.schemas or {}
          vim.list_extend(new_config.settings.yaml.schemas, require("schemastore").yaml.schemas())
        end,
        settings = {
          yaml = {
            format = { enable = true },
            validate = { enable = true },
            keyOrdering = false,
          },
        },
      },
    },
  },
}
