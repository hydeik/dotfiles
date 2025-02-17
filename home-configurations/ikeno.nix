{ pkgs, ... }:
let
  inherit (pkgs.stdenv) isDarwin;
in
{
  home = {
    username = "ikeno";
    stateVersion = "24.11";
    homeDirectory = if isDarwin then "/Users/ikeno" else "/home/ikeno";
  };

  program.git = {
    userName = "Hidekazu Ikeno";
    userEmail = "hide.ikeno@gmail.com";
  };
}
