{ lib, ... }:
{
  hydeik.shells.homeManager =
    { pkgs, ... }:
    {
      programs.atuin = {
        daemon.enable = true;
        enable = true;
        enableNushellIntegration = false;
        settings = {
          auto_sync = true;
          update_check = false;
          # sync_address = "https://api.atuin.sh";
          show_preview = true;
          sync.record = true;
        };
      };

      xdg.dataFile."nushell/vendor/autoload/atuin.nu".source =
        pkgs.runCommand "atuin.nu"
          {
            nativeBuildInputs = [ pkgs.writableTmpDirAsHomeHook ];
          }
          ''
            ${lib.getExe pkgs.atuin} init nu >> "$out"
          '';
    };
}
