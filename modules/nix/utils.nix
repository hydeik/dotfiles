{
  flake.moduels.homeManager.base =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        nix-diff
        nix-fast-build
        nix-tree
        nvd
      ];
    };
}
