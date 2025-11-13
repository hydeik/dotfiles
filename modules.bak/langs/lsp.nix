{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        vscode-langservers-extracted
        copilot-language-server
        efm-langserver
      ];
    };

  nixpkgs.allowUnfreePackages = [
    "copilot-language-server"
  ];
}
