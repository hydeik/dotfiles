return function()
  require("lspconfig").ruff.setup {
    capabilities = require("rc.plugins.lsp.utils").make_client_capabilities(),
    settings = {
      cmd_env = {
        RUFF_TRACE = "messages",
      },
      init_options = {
        settings = {
          logLevel = "error",
        },
      },
    },
  }
end
