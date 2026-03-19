{ den, hydix, ... }:
{
  den.aspects.silmeria = {
    includes = [
      (den.lib.perHost hydix.nix-settings)
      (den.lib.perHost hydix.darwin)
    ];
  };
}
