{
  hydeik.cli-tui = {
    homeManager =
      { config, pkgs, ... }:
      {
        home.packages = with pkgs; [
          bandwhich
          curl
          dust
          fd
          # ffmpeg-full # FIXME: enable after https://github.com/NixOS/nixpkgs/issues/511265 is solved
          file
          gnutar
          gping
          imagemagick
          lsof
          nkf
          p7zip
          procs
          ripgrep
          ripgrep-all
          skim
          television
          tokei
          unar
          unzip
          zip
          zstd
          watchexec
          wget
        ];

        home.sessionVariables = {
          # less
          LESSHISTFILE = "${config.xdg.cacheHome}/less/history";
        };

        programs = {
          bat.enable = true;
          bottom = {
            enable = true;
            settings = {
              rate = 500;
            };
          };
          btop = {
            enable = true;
            settings = {
              vim_keys = true;
            };
          };
          eza.enable = true;
          fzf = {
            enable = true;
            defaultCommand = "fd --type f";
            defaultOptions = [
              "--height=50%"
              "--border"
            ];
            changeDirWidgetCommand = "fd --type d";
            fileWidgetCommand = "fd --type f";
            fileWidgetOptions = [
              "--multi"
              "--preview"
              "'head -$LINES {}'"
            ];
            tmux = {
              enableShellIntegration = true;
              shellIntegrationOptions = [ "-p" ];
            };
          };
          info.enable = true;
          tealdeer = {
            enable = true;
            settings.display.use_pager = true;
          };
        };
      };
  };
}
