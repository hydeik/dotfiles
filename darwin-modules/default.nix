{
  pkgs,
  inputs,
  ezModules,
  ...
}:
{
  imports = with ezModules; [
    fonts
    homebrew
  ];

  environment = {
    pathsToLink = [
      "/share/zsh"
    ];
    systemPackages = with pkgs; [
      coreutils
      home-manager
      pam-reattach
      zsh
    ];
  };

  nix = {
    # extraOptions = "experimental-features = nix-command flakes";

    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
      interval = {
        Hour = 0;
        Minute = 0;
        Weekday = 0;
      };
    };

    settings = {
      accept-flake-config = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-substituters = [
        "https://cache.nixos.org?priority=7"
        "https://nix-community.cachix.org?priority=5"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      trusted-users = [ "root" "@wheel" "@admin"  ];
      use-xdg-base-directories = true;
    };
  };

  nixpkgs.config = import ../nixpkgs-config.nix;

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
        orientation = "bottom";
      };
    };
  };
}
