{ config, ... }:
{
  flake.modules.darwin."darwinConfigurations/lenneth" = {
    imports = with config.flake.modules.darwin; [
      desktop
      ikeno
    ];
    nixpkgs.hostPlatform = "x86_64-darwin";
    system.stateVersion = 6;
  };
}
