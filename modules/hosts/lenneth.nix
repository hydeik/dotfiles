{ den, hydix, ... }:
{
  den.aspects.lenneth = {
    includes = [
      (den.lib.perHost hydix.nix-settings)
      (den.lib.perHost hydix.darwin)
    ];
  };
}
