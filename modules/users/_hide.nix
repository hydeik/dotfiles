{ config, ... }:
{
  flake = {
    meta.hide.username = "hide";

    modules.darwin.hide = {
      nix.settings.trusted-users = [ config.flake.meta.hide.username ];
      users.users.${config.flake.meta.hide.username}.home = "/Users/${config.flake.meta.hide.username}";
    };
  };
}
