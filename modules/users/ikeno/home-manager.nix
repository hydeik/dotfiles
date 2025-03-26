{ config, ... }:
{
  flake.modules.darwin.ikeno = {
    home-manager = {
      extraSpecialArgs = {
        hasDifferentUsername = true;
      };

      users.${config.flake.meta.ikeno.username} = {
        home = {
          inherit (config.flake.meta.ikeno) username;
          stateVersion = "25.05";
          homeDirectory = "/Users/${config.flake.meta.ikeno.username}";
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
