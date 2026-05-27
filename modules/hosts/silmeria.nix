{ den, hydix, ... }:
{
  den.aspects.silmeria = {
    includes = [
      hydix.nix-settings
      hydix.darwin
    ];
  };
}
