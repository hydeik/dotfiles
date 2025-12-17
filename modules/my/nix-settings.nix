let
  my.nix-settings = {
    nixos = nix-settings;
    darwin = nix-settings;
  };

  nix-settings =
    { pkgs, config, ... }:
    {
      nix = {
        # Disable nix channels
        channel.enable = false;

        settings = {
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

        optimise = pkgs.lib.mkMerge [
          { automatic = true; }
          (pkgs.lib.attrsets.optionalAttrs (pkgs.stdenvNoCC.isDarwin) {
            interval = {
              Weekday = 7;
              Hour = 4;
              Minute = 15;
            };
          })
          (pkgs.lib.attrsets.optionalAttrs (pkgs.stdenvNoCC.isLinux) {
            date = "weekly";
          })
        ];

        gc = pkgs.lib.optionalAttrs config.nix.enable (
          pkgs.lib.mkMerge [
            {
              automatic = true;
              options = "--delete-older-than 7d";
            }
            (pkgs.lib.attrsets.optionalAttrs (pkgs.stdenvNoCC.isDarwin) {
              interval = {
                Weekday = 7;
                Hour = 3;
                Minute = 15;
              };
            })
            (pkgs.lib.attrsets.optionalAttrs (pkgs.stdenvNoCC.isLinux) {
              date = "weekly";
            })
          ]
        );
      };
    };
in
{
  inherit my;
}
