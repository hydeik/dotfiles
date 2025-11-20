{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        nushell
      ];
    };
  # { config, pkgs, ... }:
  # let
  #   pluginNamesNixpkgs = [
  #     "formats"
  #     "gstat"
  #     "highlight"
  #     "query"
  #   ];
  #
  #   activateNushellPluginsNuScript = pkgs.writeTextFile {
  #     name = "activateNushellPlugins";
  #     destination = "/bin/activateNushellPlugins.nu";
  #     text = ''
  #       #!/usr/bin/env nu
  #       ${builtins.concatStringsSep "\n" (
  #         map (x: "plugin add ${pkgs.nushellPlugins.${x}}/bin/nu_plugin_${x}") pluginNamesNixpkgs
  #       )}
  #     '';
  #   };
  #
  #   msgPackz = pkgs.runCommand "nushellMsgPackz" { } ''
  #     mkdir -p "$out"
  #     # After some experimentation, I determined that this only works if --plugin-config is FIRST
  #     ${pkgs.nushell}/bin/nu --plugin-config "$out/plugin.msgpackz" ${activateNushellPluginsNuScript}/bin/activateNushellPlugins.nu
  #   '';
  # in
  # {
  #   home.packages =
  #     with pkgs;
  #     [
  #       nu_scripts
  #     ]
  #     ++ builtins.map (x: pkgs.nushellPlugins.${x}) pluginNamesNixpkgs;
  #
  #   programs.nushell = {
  #     enable = true;
  #     environmentVariables = config.home.sessionVariables;
  #   };
  #
  #   xdg.configFile."nushell/plugin.msgpackz".source = "${msgPackz}/plugin.msgpackz";
  # };
}
