{ config, ... }:
{
  flake = {
    meta.hide = {
      username = "hide";
      email = "hide.ikeno@gmail.com";
    };

    modules.darwin.hide = {
      users.users.${config.flake.meta.hide.username} = {
        isNormalUser = true;
        initialPassword = "";
      };

      home-manager = {
        users.${config.flake.meta.hide.username} = _: {
          imports = [ config.flake.modules.homeManager.hide ];
          home = {
            stateVersion = "25.05";
            username = "${config.flake.meta.hide.username}";
            homeDirectory = "/home/${config.flake.meta.hide.username}";
          };
        };
      };
    };
  };
}
