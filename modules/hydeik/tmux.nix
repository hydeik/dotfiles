{ lib, ... }:
{
  hydeik.tmux.homeManager =
    { config, pkgs, ... }:
    let
      inherit (pkgs.stdenv) isDarwin;
      inherit (lib) optionals;
    in
    {
      home = {
        packages =
          (builtins.attrValues {
            inherit (pkgs)
              tmux
              tmux-sessionizer
              tmux-xpanes
              ;
            inherit (pkgs.tmuxPlugins)
              battery
              catppuccin
              copycat
              cpu
              open
              prefix-highlight
              resurrect
              ;
          })
          ++ optionals isDarwin (
            builtins.attrValues {
              inherit (pkgs)
                reattach-to-user-namespace
                ;
            }
          );

        sessionVariables = {
          TMS_CONFIG_FILE = "${config.xdg.configHome}/tms/config.toml";
        };
      };
    };
}
