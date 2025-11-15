{ config, ... }:
{
  flake.modules.darwin.hide = {
    home-manager = {
      extraSpecialArgs = {
        hasDifferentUsername = true;
      };

      users.${config.flake.meta.hide.username} = {
        home = {
          inherit (config.flake.meta.hide) username;
          stateVersion = "25.05";
          homeDirectory = "/Users/${config.flake.meta.hide.username}";
        };
        imports = [
          config.flake.modules.homeManager.base
          config.flake.modules.homeManager.gui or { }
        ];
        style.windowOpacity = 0.9;
        style.bellDuration = 0;
      };
    };
  };
}
