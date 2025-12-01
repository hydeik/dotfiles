{ inputs, ... }:
let
  flake-file.inputs.catppuccin = {
    url = "github:catppuccin/nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flavor = "mocha";

  hydeik.catppuccin.homeManager = {
    imports = [
      inputs.catppuccin.homeModules.catppuccin
    ];
    catppuccin = {
      enable = true;
      inherit flavor;
    };
  };
in
{
  inherit flake-file;
  inherit hydeik;
}
