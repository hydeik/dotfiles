{
  flake.modules.homeManager.base =
    { config, pkgs, ... }:
    {
      home.packages = [ pkgs.ghq ];
      programs.git.settings = {
        ghq.root = "${config.home.homeDirectory}/src";
      };
    };
}
