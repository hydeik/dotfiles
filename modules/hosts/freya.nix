{ den, hydix, ... }:
{
  den.aspects.freya = {
    includes = [
      (den.lib.perHost hydix.nix-settings)
      (den.lib.perHost hydix.darwin)
    ];
  };
}
