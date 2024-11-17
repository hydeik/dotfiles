return function()
  require("lspconfig").nixd.setup {
    capabilities = require("rc.plugins.lsp.utils").make_client_capabilities(),
    settings = {
      nixd = {
        nixpkgs = {
          expr = "import <nixpkgs> { }",
        },
        formatting = {
          command = { "nixfmt" },
        },
        -- options = {
        --   nixos = {
        --     expr = '(builtins.getFlake "/tmp/NixOS_Home-Manager").nixosConfigurations.hostname.options',
        --   },
        --   home_manager = {
        --     expr = '(builtins.getFlake "/tmp/NixOS_Home-Manager").homeConfigurations."user@hostname".options',
        --   },
        --   flake_parts = {
        --     expr = 'let flake = builtins.getFlake ("/tmp/NixOS_Home-Manager"); in flake.debug.options // flake.currentSystem.options',
        --   },
        -- },
      },
    },
  }
end
