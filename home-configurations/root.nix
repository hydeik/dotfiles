{ osConfig, ... }:
{
  programs.ssh.enable = true;
  home = {
    username = "root";
    stateVersion = "24.11";
    homeDirectory = osConfig.users.users.root.home;
  };
}
