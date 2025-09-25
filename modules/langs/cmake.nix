{
  perSystem.treefmt.programs.cmake-format.enable = true;

  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        cmake-language-server
        cmake-lint
      ];
    };
}
