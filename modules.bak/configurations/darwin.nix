{
  inputs,
  lib,
  config,
  ...
}:
{
  options.configurations.darwin = lib.mkOption {
    type = lib.types.lazyAttrsOf (
      lib.types.submodule {
        options.module = lib.mkOption {
          type = lib.types.deferredModule;
        };
      }
    );
  };

  config.flake = {
    darwinConfigurations = lib.flip lib.mapAttrs config.configurations.darwin (
      _name: { module }: inputs.nix-darwin.lib.darwinSystem { modules = [ module ]; }
    );

    checks =
      config.flake.darwinConfigurations
      |> lib.mapAttrsToList (
        name: darwin: {
          ${darwin.config.nixpkgs.hostPlatform.system} = {
            "configurations/darwin/${name}" = darwin.config.system.build.toplevel;
          };
        }
      )
      |> lib.mkMerge;
  };
}
