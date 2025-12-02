{
  hydeik.terminals = {
    darwin =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          iterm2
        ];
      };

    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          alacritty
          # ghostty
          kitty
          wezterm
        ];

        xdg.configFile."alacritty/terminal.toml".text = ''
          [terminal.shell]
          program = "${pkgs.zsh}/bin/zsh"
          args = ["--login"]
        '';
      };
  };
}
