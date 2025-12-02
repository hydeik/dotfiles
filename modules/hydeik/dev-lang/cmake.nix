{
  hydeik.dev-lang = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          cmake-format
          cmake-language-server
          cmake-lint
        ];
      };
  };
}
