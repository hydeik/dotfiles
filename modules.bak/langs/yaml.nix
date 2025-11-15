{
  perSystem.treefmt.programs.yamlfmt.enable = true;

  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        # Language server
        yaml-language-server
      ];
    };
}
