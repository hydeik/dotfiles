{
  hydeik.jujutsu.homeManager =
    { config, pkgs, ... }:
    {
      home.packages = with pkgs; [
        lazyjj
        # jj-fzf
      ];

      programs.jujutsu =
        let
          diff-formatter = [
            (pkgs.lib.getExe pkgs.difftastic)
            "--color=always"
            "$left"
            "$right"
          ];
        in
        {
          enable = true;
          settings = {
            user = {
              name = "Hidekazu Ikeno";
              email = "hide.ikeno@gmail.com";
            };

            ui = {
              inherit diff-formatter;
              conflict-marker-style = "git";
            };

            "--scope" = [
              {
                "--when".commands = [
                  "diff"
                  "show"
                ];
                ui.diff-formatter = diff-formatter;
                ui.pager = "delta";
              }
            ];
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
