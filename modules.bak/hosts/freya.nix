{ config, ... }:
{
  configurations.darwin.freya.module = {
    imports = with config.flake.modules.darwin; [
      desktop
      hide
    ];
    nixpkgs.hostPlatform = "x86_64-darwin";
    system.stateVersion = 6;
  };
}
