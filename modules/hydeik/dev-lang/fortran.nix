{
  hydeik.dev-lang = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          gfortran
          flang # Build failed on x86_64-darwin
          # fortitude # Linter -- build failed
          fortls # LSP
        ];
      };
  };
}
