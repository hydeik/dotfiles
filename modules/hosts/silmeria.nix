{ config, ... }:
{
  flake.modules.darwin."darwinConfigurations/silmeria" = {
    imports = with config.flake.modules.darwin; [
      desktop
      ikeno
    ];
    nixpkgs.hostPlatform = "aarch64-darwin";
    system.stateVersion = 6;
  };
}
