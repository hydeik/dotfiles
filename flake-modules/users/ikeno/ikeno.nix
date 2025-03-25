{ config, ... }:
{
  flake = {
    meta.ikeno.username = "ikeno";

    modules.darwin.ikeno = {
      nix.settings.trusted-users = [ config.flake.meta.ikeno.username ];
      users.users.${config.flake.meta.ikeno.username}.home = "/Users/${config.flake.meta.ikeno.username}";
    };
  };
}
