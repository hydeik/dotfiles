{ lib, ... }:
{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      nix.package = lib.mkDefault pkgs.nix;
    };
}
