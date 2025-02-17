{ pkgs, ... }:
let
  inherit (pkgs.stdenv) isDarwin;
in
{
  home = {
    username = "hide";
    stateVersion = "24.11";
    homeDirectory = if isDarwin then "/Users/hide" else "/home/hide";
  };

  program.git = {
    userName = "Hidekazu Ikeno";
    userEmail = "hide.ikeno@gmail.com";
  };
}
