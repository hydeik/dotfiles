{ config, ... }:
{
  flake.modules.darwin."darwinConfigurations/freya" = {
    imports = with config.flake.modules.darwin; [
      desktop
    ];
    nixpkgs.hostPlatform = "x86_64-darwin";
    system.stateVersion = 6;
  };
}
