{
  ezModules,
  lib,
  inputs,
  ...
}:
{
  programs.home-manager.enable = true;

  home = {
    stateVersion = "24.11";
    preferXdgDirectories = true;
  };

  imports = lib.attrValues {
    inherit (ezModules)
      alacritty
      catppuccin
      editorconfig
      shell-utils
      tmux
      xdg
      # zsh
      ;
  };

  nixpkgs.config = import ../nixpkgs-config.nix;
  xdg.configFile."nixpkgs/config.nix".source = ../nixpkgs-config.nix;
}
