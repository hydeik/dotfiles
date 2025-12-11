{ lib, ... }:
{
  hydeik.shells = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          starship
        ];

        xdg.dataFile."nushell/vendor/autoload/starship.nu".source = pkgs.runCommand "starship.nu" { } ''
          ${lib.getExe pkgs.starship} init nu >> "$out"
        '';
      };
  };
}
