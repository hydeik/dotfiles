{ lib, ... }:
{
  hydeik.shells.homeManager =
    {pkgs, ...}: {
      home.packages = [
        pkgs.zoxide
      ];

      xdg.dataFile."nushell/vendor/autoload/zoxide.nu".source = pkgs.runCommand "zoxide.nu" { } ''
        ${lib.getExe pkgs.zoxide} init nushell >> "$out"
      '';
    };
}
