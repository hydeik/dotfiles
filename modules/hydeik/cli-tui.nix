{
  hydeik.cli-tui = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          bandwhich
          curl
          dust
          fd
          ffmpeg-full
          file
          jq
          gnutar
          gping
          lsof
          nkf
          p7zip
          procs
          ripgrep
          ripgrep-all
          tokei
          unar
          unzip
          zip
          zstd
          watchexec
          wget
        ];

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
