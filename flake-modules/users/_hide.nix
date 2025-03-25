{ config, ... }:
{
  flake = {
    meta.hide.username = "hide";

    modules.darwin.hide = {
      nix.settings.trusted-users = [ config.flake.meta.hide.username ];

      home-manager = {
        extraSpecialArgs = {
          hasDifferentUsername = true;
        };

        users.${config.flake.meta.hide.username} = {
          home = {
            stateVersion = "25.05";
            inherit (config.flake.meta.hide) username;
            homeDirectory = "/Users/${config.flake.meta.hide.username}";
          };
          imports = [
            config.flake.modules.homeManager.base
            config.flake.modules.homeManager.gui or { }
          ];
        };
      };
    };
  };
}
