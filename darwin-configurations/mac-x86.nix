{ inputs, pkgs, ... }:

{
  nixpkgs.hostPlatform = "x86_64-darwin";
  system.stateVersion = 5;
  nix = {
    enable = true;
  };
}
