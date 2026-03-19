let
  common-settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    extra-substituters = [
      "https://yazi.cachix.org"
    ];
    extra-trusted-public-keys = [
      "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="
    ];
    substituters = [
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
    trusted-users = [
      "root"
      "@wheel"
    ];
  };

  optimise-darwin = {
    automatic = true;
    interval = {
      Weekday = 7;
      Hour = 4;
      Minute = 15;
    };
  };

  optimise-linux = {
    automatic = true;
    date = "weekly";
  };

  gc-darwin = {
    automatic = true;
    options = "--delete-older-than 7d";
    interval = {
      Weekday = 7;
      Hour = 3;
      Minute = 15;
    };
  };

  gc-linux = {
    automatic = true;
    options = "--delete-older-than 7d";
    date = "weekly";
  };
in
{
  hydix.nix-settings = {
    nixos = {
      nix = {
        channel.enable = false;
        settings = common-settings;
        optimise = optimise-linux;
        gc = gc-linux;
      };
    };

    darwin = {
      nix = {
        channel.enable = false;
        settings = common-settings;
        optimise = optimise-darwin;
        gc = gc-darwin;
      };
    };
  };
}
