{
  hydeik.dev-lang = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          # Language server
          texlab
          # TODO:: setup texlive
        ];
      };
  };
}
