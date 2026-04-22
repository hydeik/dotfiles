{
  hydeik.ai.homeManager =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        github-copilot-cli
        copilot-language-server
      ];
    };
}
