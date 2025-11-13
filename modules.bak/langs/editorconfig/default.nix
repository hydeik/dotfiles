{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      home = {
        packages = [
          pkgs.editorconfig-core-c
        ];
        file = {
          ".editorconfig".source = ./.editorconfig;
        };
      };
    };
}
