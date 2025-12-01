{ den, ... }:
{
  flake-file.inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ## these stable inputs are for wsl
    #nixpkgs-stable.url = "github:nixos/nixpkgs/release-25.05";
    #home-manager-stable.url = "github:nix-community/home-manager/release-25.05";
    #home-manager-stable.inputs.nixpkgs.follows = "nixpkgs-stable";

    #nixos-wsl = {
    #  url = "github:nix-community/nixos-wsl";
    #  inputs.nixpkgs.follows = "nixpkgs-stable";
    #  inputs.flake-compat.follows = "";
    #};
  };

  den.default.includes = [ den._.home-manager ];
}
