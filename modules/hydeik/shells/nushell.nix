{ lib, ... }:
{
  hydeik.shells.homeManager =
    { pkgs, ... }:
    let
      inherit (pkgs.stdenvNoCC) isLinux;

      nuPluginNixpkgs =
        with pkgs;
        [
          nushell-plugin-formats
          # nushell-plugin-hcl # FIXME: waiting for update to 0.111
          # nushell-plugin-highlight # FIXME: waiting for update to 0.111
          nushell-plugin-gstat
          # nushell-plugin-net # broken
          nushell-plugin-polars
          nushell-plugin-query
          nushell-plugin-semver
          nushell-plugin-skim
          # nushell-plugin-units # broken
        ]
        ++ lib.optionals isLinux [
          nushell-plugin-dbus
          nushell-plugin-desktop_notifications
        ];

      activateNushellPluginsNuScript = pkgs.writeTextFile {
        name = "activateNushellPlugins";
        destination = "/bin/activateNushellPlugins.nu";
        text = ''
          #!/usr/bin/env nu
          ${builtins.concatStringsSep "\n" (map (pkg: "plugin add ${lib.getExe pkg}") nuPluginNixpkgs)}
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
        nufmt
        nu_scripts
        bash-env-json
      ];

      programs.bash.profileExtra = ''
        if ! [ "$TERM" = "dumb" ] && [ -z "$BASH_EXECUTION_STRING" ]; then
          exec nu
        fi
      '';

      xdg.configFile."nushell/plugin.msgPackz".source = "${msgPackz}/plugin.msgpackz";
    };
}
