{
  perSystem.treefmt.programs = {
    shellcheck.enable = true;
    shfmt.enable = true;
  };

  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        bash-language-server
      ];
    };
}
