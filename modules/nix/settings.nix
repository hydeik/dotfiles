{ lib, config, ... }:
{
  options.nix.settings = lib.mkOption {
    type = lib.types.lazyAttrsOf lib.types.anything;
  };

  config = {
    nix.settings = {
      experimental-features = [
        "nix-command"
        "flakes"
        "pipe-operators"
        "recursive-nix"
      ];
      extra-system-features = [ "recursive-nix" ];

      use-registries = true;
      flake-registry = "";

      # Let the system decide the number of max jobs.
      max-jobs = "auto";

      # for direnv GC roots
      keep-derivations = true;
      keep-outputs = true;

      # Use XDG base directories for all the nix things.
      use-xdg-base-directories = true;
    };

    flake.modules = {
      nixos.desktop.nix = {
        inherit (config.nix) settings;
      };

      darwin.desktop.nix = {
        inherit (config.nix) settings;
      };

      homeManager.base.nix = {
        inherit (config.nix) settings;
      };
    };
  };
}
