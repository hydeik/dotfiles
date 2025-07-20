{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.vim
      ];
      # TODO: add Vim config
    };
}
