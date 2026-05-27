{ den, hydix, ... }:
{
  den.aspects.lenneth = {
    includes = [
      hydix.nix-settings
      hydix.darwin
    ];
  };
}
