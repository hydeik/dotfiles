{ config, ... }:
{
  configurations.darwin.lenneth.module = {
    imports = with config.flake.modules.darwin; [
      desktop
      ikeno
    ];
    nixpkgs.hostPlatform = "aarch64-darwin";
    system.stateVersion = 6;
  };
}
