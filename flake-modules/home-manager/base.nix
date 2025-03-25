{ config, lib, ... }:
{
  flake.modules.homeManager.base = args: {
    home = lib.mkIf (!(args.hasDifferentUsername or false)) {
      inherit (config.flake.meta.owner) username;
      homeDirectory =
        if args.pkgs.stdenv.isDarwin then
          "/Users/${config.flake.meta.owner.username}"
        else
          "/home/${config.flake.meta.owner.username}";
    };
    programs.home-manager.enable = true;
  };
}
