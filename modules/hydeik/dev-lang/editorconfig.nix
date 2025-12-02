{
  hydeik.dev-lang = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          editorconfig-core-c
        ];
      };
  };
}
