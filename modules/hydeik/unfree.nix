{ __findFile, ... }:
{
  hydeik.unfree.includes = [
    (<den/unfree> [
      "copilot-language-server"
      "cursor"
      "vscode"
    ])
  ];
}
