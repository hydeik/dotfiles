{ config, lib, ... }:
{
  flake.modules.homeManager.base = args: {
    home = lib.mkIf (!(args.hasDifferentUsername or false)) {
      inherit (config.flake.meta.owner) username;
      homeDirectory = "/home/${config.flake.meta.owner.username}";
    };
    programs.home-manager.enable = true;
  };
}
