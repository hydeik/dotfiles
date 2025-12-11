{ lib, ... }:
{
  hydeik.shells = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          carapace
        ];

        xdg.dataFile."nushell/vendor/autoload/carapace.nu".source = pkgs.runCommand "carapace.nu" { } ''
          ${lib.getExe pkgs.carapace} _carapace nushell | sed 's|"/homeless-shelter|$"($env.HOME)|g' >> "$out"
        '';
      };
  };
}
