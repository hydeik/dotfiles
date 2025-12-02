{
  hydeik.dev-lang = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          # LSP server
          sqls
          # Formatter
          sql-formatter

          # SQLite
          sqlite
          sqlitebrowser
        ];

        home.sessionVariables = {
          LIBSQLITE = "${pkgs.sqlite.out}/lib/libsqlite3${pkgs.stdenv.hostPlatform.extensions.sharedLibrary}";
        };
      };
  };
}
