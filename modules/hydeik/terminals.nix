{
  hydeik.terminals = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = pkgs.lib.mkIf (!pkgs.stdenvNoCC.isDarwin) [
          pkgs.alacritty
          pkgs.ghostty
          pkgs.kitty
          pkgs.wezterm
        ];

        xdg.configFile."alacritty/terminal.toml".text = ''
          [env]
          SHELL = "${pkgs.zsh}/bin/zsh"

          [terminal]
          osc52 = "CopyPaste"

          [terminal.shell]
          program = "${pkgs.zsh}/bin/zsh"
          args = ["-c", "tms start"]
        '';
      };
  };
}
