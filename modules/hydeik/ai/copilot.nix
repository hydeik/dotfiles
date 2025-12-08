{
  hydeik.ai.homeManager =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        copilot-cli
        copilot-language-server
      ];
    };
}
