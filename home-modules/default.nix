{ ezModules, lib, inputs, ... }:
{
  programs.home-manager.enable = true;

  home = {
    stateVersion = "24.11";
    preferXdgDirectories = true;
  };

  imports = lib.attrValues
    {
      inherit(ezModules)
        xdg
        ;
    };
}
