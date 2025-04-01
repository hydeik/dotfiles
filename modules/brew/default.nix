{ inputs, ... }:
{
  flake.modules.darwin.desktop =
    { pkgs, ... }:
    {
      imports = [ inputs.brew-nix.darwinModules.default ];
      brew-nix.enable = true;
      environment.systemPackages = with pkgs.brewCasks; [
        ghostty
        gimp
        inkscape
      ];
    };
}
