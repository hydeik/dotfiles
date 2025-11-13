{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        # Package manager
        pixi
        uv
        # Language server / Linter / Formatter
        ruff
      ];
    };
}
