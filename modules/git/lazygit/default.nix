{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      # I do not use `programs.lazygit.settings` to avoid IDF.
      home.packages = [ pkgs.lazygit ];
      xdg.configFile."lazygit/config.yml".source = ./config.yml;
    };
}
