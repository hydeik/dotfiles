{ inputs, lib, ... }:
{
  flake-file = {
    description = "Hidekazu Ikeno (hydeik)'s dotfile powered by Nix";
    inputs = {
      den.url = lib.mkDefault "github:vic/den";
      flake-file.url = lib.mkDefault "github:vic/flake-file";
    };
  };
  imports = [
    (inputs.flake-file.flakeModules.dendritic or { })
    (inputs.den.flakeModules.dendritic or { })
  ];
}
