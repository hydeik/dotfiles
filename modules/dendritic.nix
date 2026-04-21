{ inputs, lib, ... }:
{
  flake-file = {
    description = "Hidekazu Ikeno (hydeik)'s dotfile powered by Nix";
    inputs = {
      den.url = "github:vic/den";
      flake-file.url = "github:vic/flake-file";
      home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
      };
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    };
  };
  imports = [
    (inputs.flake-file.flakeModules.dendritic or { })
    (inputs.den.flakeModules.dendritic or { })
  ];
}
