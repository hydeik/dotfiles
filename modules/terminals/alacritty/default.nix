{
  flake.modules.homeManager.gui =
    { config, pkgs, ... }:
    {
      xdg.configFile = {
        "alacritty/alacritty.toml".source = pkgs.substituteAll {
          src = ./alacritty.toml;
          catppuccin_alacritty = "${config.catppuccin.sources.alacritty}/catppuccin-${config.catppuccin.flavor}.toml";
          zsh_path = "${pkgs.zsh}/bin/zsh";
        };
        "alacritty/fonts" = {
          recursive = true;
          source = ./fonts;
        };
        "alacritty/themes" = {
          recursive = true;
          source = ./themes;
        };
      };
    };
}
