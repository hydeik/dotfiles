{ lib, ... }:
{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      home.packages = lib.attrValues {
        inherit (pkgs.luajitPackages) luarocks;

        inherit (pkgs)
          # Body
          neovim
          # Dependency
          sqlite
          tree-sitter
          ;
      };

      home.sessionVariables = {
        LIBSQLITE = "${pkgs.sqlite.out}/lib/libsqlite3${pkgs.stdenv.hostPlatform.extensions.sharedLibrary}";
      };
    };
}
