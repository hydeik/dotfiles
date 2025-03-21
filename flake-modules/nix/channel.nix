{ lib, config, ... }:
{
  options.nix.channel.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };

  config = {
    # Disable usage of nix channels
    nix.channel.enable = false;

    flake.modules = {
      nixos.desktop.nix = {
        inherit (config.nix) channel;
      };

      darwin.desktop.nix = {
        inherit (config.nix) channel;
      };
    };
  };
}
