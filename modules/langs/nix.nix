{
  perSystem.treefmt.programs = {
    deadnix.enable = true;
    nixf-diagnose.enable = true;
    statix.enable = true;
  };

  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        # Language servers
        nixd
      ];
    };
}
