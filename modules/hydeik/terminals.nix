{
  hydeik.terminals = {
    darwin =
      { pkgs, ... }:
      {
        home.package = with pkgs; [
          iterm2
        ];
      };

    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          alacritty
          ghostty
          kitty
          wezterm
        ];
      };
  };
}
