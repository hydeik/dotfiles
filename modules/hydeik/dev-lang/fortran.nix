{
  hydeik.dev-lang = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          gfortran
          flang
          # fortitude # Linter
          fortls # LSP
        ];
      };
  };
}
