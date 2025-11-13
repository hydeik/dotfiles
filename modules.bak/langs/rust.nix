{
  perSystem.treefmt.programs.rustfmt.enable = true;

  flake.modules.flakeModules.base =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        cargo-watch
        cargo-outdated
        cargo-feature
      ];
    };
}
