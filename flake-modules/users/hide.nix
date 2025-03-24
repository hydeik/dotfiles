{ config, ... }:
{
  flake = {
    meta.hide.username = "ikeno";

    modules.darwin.hide = {
      nix.settings.trusted-users = [ config.flake.meta.hide.username ];

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = {
          hasGlobalPkgs = true;
          hasDifferentUsername = true;
        };
        users.${config.flake.meta.hide.username}.imports = [
          (_: {
            home = {
              stateVersion = "25.05";
              username = config.flake.meta.hide.username;
              homeDirectory = "/Users/${config.flake.meta.hide.username}";
            };
          })
          config.flake.modules.homeManager.base
          config.flake.modules.homeManager.gui or { }
        ];
      };
    };
  };
}
