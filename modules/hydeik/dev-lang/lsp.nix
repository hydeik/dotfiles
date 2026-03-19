{ ... }:
{
  hydeik.dev-lang = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          vscode-langservers-extracted
          efm-langserver
        ];
      };
  };
}
