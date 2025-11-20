{
  perSystem.treefmt.programs.rustfmt.enable = true;

  flake.modules.flakeModules.base =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        cargo
        cargo-watch
        cargo-outdated
        cargo-feature
        rustc
      ];
    };
}
