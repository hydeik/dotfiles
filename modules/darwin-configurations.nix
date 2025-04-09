{
  config,
  lib,
  inputs,
  ...
}:
let
  prefix = "darwinConfigurations/";
in
{
  flake = {
    darwinConfigurations =
      config.flake.modules.darwin or { }
      |> lib.filterAttrs (name: _module: lib.hasPrefix prefix name)
      |> lib.mapAttrs' (
        name: module:
        let
          hostName = lib.removePrefix prefix name;
        in
        {
          name = hostName;
          value = inputs.nix-darwin.lib.darwinSystem {
            system = module.nixpkgs.hostPlatform;
            modules = [
              module
              { networking = { inherit hostName; }; }
            ];
          };
        }
      );
    checks =
      config.flake.darwinConfigurations
      |> lib.mapAttrsToList (
        name: darwin: {
          ${darwin.config.nixpkgs.hostPlatform.system} = {
            "${prefix}${name}" = darwin.config.system.build.toplevel;
          };
        }
      )
      |> lib.mkMerge;
  };
}
