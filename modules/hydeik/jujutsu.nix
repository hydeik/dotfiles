{
  hydeik.jujutsu.homeManager =
    { config, pkgs, ... }:
    {
      home.packages = with pkgs; [
        lazyjj
        # jj-fzf
      ];

      programs.jujutsu = {
        enable = true;
        settings = {
          user = {
            name = "Hidekazu Ikeno";
            email = "hide.ikeno@gmail.com";
          };
        };
      };

      programs.jjui = {
        enable = true;
        configDir = "${config.xdg.configHome}/jjui";
        settings = {
          suggest.exec.mode = "fuzzy";
        };
      };
    };
}
