{
  hydeik.ai.homeManager =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        gemini
      ];
    };
}
