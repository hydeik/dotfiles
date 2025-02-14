{ pkgs, inputs, ezModules, ... }: {

  nix = {
    extraOptions = "experimental-features = nix-command flakes";

    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
      interval = {
        Hour = 0;
        Minite = 0;
        Weekday = 0;
      };
    };

    settings = {
      trusted-users = [ "@admin" ];
      trusted-substituters = [ "https://nix-community.cachix.org" ];
      extra-substituters = [ "https://nix-community.cachix.org" ];
      extra-trusted-public-keys = [ "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" ];
    };
  };

  security.pam.enableSudoTouchIdAuth = true;

  system = {
    defaults = {
      NSGlobalDomain = {
        InitialKeyRepeat = 15;
        KeyRepeat = 2;
      };

      finder = {
        AppleShowAllFiles = true;
        AppleShowAllExtensions = true;
      };

      dock = {
        autohide = true;
        show-recents = false;
        orientation = "left";
      };
    };
  };
}
