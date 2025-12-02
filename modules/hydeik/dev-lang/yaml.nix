{

  hydeik.dev-lang = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          yamlfix
          yamlfmt
          yamllint
          yaml-language-server
        ];
      };
  };
}
