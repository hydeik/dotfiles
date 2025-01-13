{ pkgs, catppuccin, ... }:
let
  inherit (pkgs.stdenv) isDarwin;
in
{
  imports = [
    catppuccin.homeManagerModules.catppuccin
  ];

  home = {
    username = "ikeno";
    stateVersion = "24.11";
    homeDirectory = if isDarwin then "/Users/ikeno" else "/home/ikeno";
  };

  programs.git = {
    userName = "Hidekazu Ikeno";
    userEmail = "hide.ikeno@gmail.com";
  };
}
