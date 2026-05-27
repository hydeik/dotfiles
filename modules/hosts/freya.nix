{ den, hydix, ... }:
{
  den.aspects.freya = {
    includes = [
      hydix.nix-settings
      hydix.darwin
    ];
  };
}
