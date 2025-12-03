{ __findFile, ... }:
{
  hydeik.dev-lang = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          vscode-langservers-extracted
          copilot-language-server
          efm-langserver
        ];
      };
  };
}
