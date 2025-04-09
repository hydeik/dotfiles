{ inputs, ... }:
{
  flake.modules.nixos.desktop.nix.nixPath = [
    "nixpkgs=${inputs.nixpkgs}"
  ];

  flake.modules.darwin.desktop.nix.nixPath = [
    "nixpkgs=${inputs.nixpkgs}"
  ];
}
