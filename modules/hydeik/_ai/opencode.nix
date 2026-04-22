{
  hydeik.ai.homeManager =
    { pkgs, ... }:
    {
      programs.opencode = {
        enable = pkgs.stdenv.hostPlatform.system != "x86_64-darwin";
        settings = {
          autoupdate = false;
          theme = "catppuccin";
        };
      };
    };
}
