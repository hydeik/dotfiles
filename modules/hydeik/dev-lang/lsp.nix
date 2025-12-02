{ __findFile, ... }:
{
  hydeik.dev-lang = {
    includes = [
      (<den/unfree> [ "copilot-language-server" ])
    ];

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
