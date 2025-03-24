{ config, ... }:
{
  flake = {
    meta.ikeno.username = "ikeno";

    # modules.nixos.ikeno = {
    #   nix.settings.trusted-users = [ config.flake.meta.ikeno.username ];
    #   users.users.${config.flake.meta.ikeno.username} = {
    #     isNormalUser = true;
    #     initialPassword = "";
    #     extraGroups = [
    #       "whieel"
    #       "input"
    #     ];
    #   };
    #
    #   home-manager = {
    #     useGlobalPkgs = true;
    #     useUserPackages = true;
    #     extraSpecialArgs = {
    #       hasGlobalPkgs = true;
    #       hasDifferentUsername = true;
    #     };
    #     users.${config.flake.meta.ikeno.username}.imports = [
    #       (_: {
    #         home = {
    #           stateVersion = "25.05";
    #           username = config.flake.meta.ikeno.username;
    #           # homeDirectory = "/Users/${config.flake.meta.ikeno.username}";
    #           homeDirectory = /home + config.flake.meta.ikeno.username;
    #         };
    #       })
    #       config.flake.modules.homeManager.base
    #       config.flake.modules.homeManager.gui or { }
    #     ];
    #   };
    # };

    modules.darwin.ikeno = {
      nix.settings.trusted-users = [ config.flake.meta.ikeno.username ];

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = {
          hasGlobalPkgs = true;
          hasDifferentUsername = true;
        };

        users.${config.flake.meta.ikeno.username} = {
          home = {
            stateVersion = "25.05";
            username = config.flake.meta.ikeno.username;
            homeDirectory = "/Users/${config.flake.meta.ikeno.username}";
          };
          imports = [
            config.flake.modules.homeManager.base
            config.flake.modules.homeManager.gui or { }
          ];
        };

        # config = {
        #   imports = [
        #     config.flake.modules.homeManager.base
        #     config.flake.modules.homeManager.gui or { }
        #   ];
        #   home = {
        #     stateVersion = "25.05";
        #     username = config.flake.meta.ikeno.username;
        #     homeDirectory = "/Users/${config.flake.meta.ikeno.username}";
        #   };
        # };
        # users.${config.flake.meta.ikeno.username}.imports = [
        #   (_: {
        #     home = {
        #       stateVersion = "25.05";
        #       username = config.flake.meta.ikeno.username;
        #       homeDirectory = "/Users/${config.flake.meta.ikeno.username}";
        #     };
        #   })
        #   config.flake.modules.homeManager.base
        #   config.flake.modules.homeManager.gui or { }
        # ];
      };
    };
  };
}
