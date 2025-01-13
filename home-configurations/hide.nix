{ pkgs, catppuccin, ... }:
let
  inherit (pkgs.stdenv) isDarwin;
in
{
  imports = [
    catppuccin.homeManagerModules.catppuccin
  ];

  home = {
    username = "hide";
    stateVersion = "24.11";
    homeDirectory = if isDarwin then "/Users/hide" else "/home/hide";
  };

  programs.git = {
    userName = "Hidekazu Ikeno";
    userEmail = "hide.ikeno@gmail.com";
  };
}
