{ inputs, ... }:
let
  inherit (inputs.self.lib.mk-os)
    darwin
    darwin-intel
    ;
in
{
  flake.darwinConfigurations = {
    freya = darwin-intel "freya";
    lenneth = darwin "lenneth";
    silmeria = darwin "freya";
  };
}
