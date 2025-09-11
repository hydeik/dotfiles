{ inputs, ... }:
let
  inherit (inputs.self.lib.mk-os)
    darwin
    darwin-intel
    ;

  flake.darwinConfigurations = {
    lenneth = darwin "lenneth";
    silmeria = darwin "silmeria";
    freya = darwin-intel "freya";
  };
in
{
  inherit flake;
}
