{ inputs, ... }:
{
  flake-file = {
    description = "Hidekazu Ikeno (hydeik)'s dotfile powered by Nix";
    inputs = {
      den.url = "github:denful/den";
      flake-file.url = "github:denful/flake-file";
      home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
      };
      import-tree.url = "github:denful/import-tree";
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    };
  };
  imports = [
    (inputs.flake-file.flakeModules.dendritic or { })
    (inputs.den.flakeModules.dendritic or { })
  ];
}
