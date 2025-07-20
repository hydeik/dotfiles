{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        bandwhich
        curl
        gping
        wget
      ];
    };
}
