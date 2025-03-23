{ config, lib, ... }:
{
  flake.modules.homeManager.base = args: {
    home = lib.mkIf (!(args.hasDifferentUsername or false)) {
      username = config.flake.meta.owner.username;
      homeDirectory =
        if args.isDarwin then
          "/Users/${config.flake.meta.owner.username}"
        else
          "/home/${config.flake.meta.owner.username}";
    };
    programs.home-manager.enable = true;
  };
}
