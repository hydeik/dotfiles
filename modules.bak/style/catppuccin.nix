{
  lib,
  inputs,
  ...
}:
let
  flavor = "mocha";
in
{
  flake.modules = {
    nixos.desktop = {
      imports = [ inputs.catppuccin.nixosModules.catppuccin ];
      catppuccin = {
        enable = true;
        inherit flavor;
      };
    };
    homeManager.base = {
      imports = [ inputs.catppuccin.homeModules.catppuccin ];
      options = {
        style = {
          windowOpacity = lib.mkOption {
            type = lib.types.numbers.between 0 1.0;
            default = 1.0;
          };
          bellDuration = lib.mkOption {
            type = lib.types.numbers.between 0 1000;
            default = 200;
          };
        };
      };
      config = {
        catppuccin = {
          enable = true;
          inherit flavor;
        };
      };
    };
  };
}
