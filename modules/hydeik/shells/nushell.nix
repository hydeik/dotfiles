{ lib, ... }:
{
  hydeik.shells.homeManager =
    { pkgs, ... }:
    let
      inherit (lib.strings) concatStringsSep;
      inherit (pkgs.stdenvNoCC) isLinux;

      pluginNamesNixpkgs = [
        "formats"
        "hcl"
        "highlight"
        "gstat"
        # "net" # broken
        "polars"
        "query"
        "semver"
        "skim"
        # "units" # broken
      ]
      ++ pkgs.lib.optionals isLinux [
        "dbus"
        "desktop_notifications"
      ];

      activateNushellPluginsNuScript = pkgs.writeTextFile {
        name = "activateNushellPlugins";
        destination = "/bin/activateNushellPlugins.nu";
        text = ''
          #!/usr/bin/env nu
          ${concatStringsSep "\n" (
            map (x: "plugin add ${pkgs.nushellPlugins.${x}}/bin/nu_plugin_${x}") pluginNamesNixpkgs
          )}
        '';
      };

      msgPackz = pkgs.runCommand "nushellMsgPackz" { } ''
        mkdir -p "$out"
        # After some experimentation, I determined that this only works if --plugin-config is FIRST
        ${pkgs.nushell}/bin/nu --plugin-config "$out/plugin.msgpackz" ${activateNushellPluginsNuScript}/bin/activateNushellPlugins.nu
      '';
    in
    {
      home.packages = with pkgs; [
        nushell
        bash-env-json
        nu_scripts
      ];

      programs.bash.profileExtra = ''
        if ! [ "$TERM" = "dumb" ] && [ -z "$BASH_EXECUTION_STRING" ]; then
          exec nu
        fi
      '';

      xdg.configFile."nushell/plugin.msgPackz".source = "${msgPackz}/plugin.msgpackz";
    };
}
