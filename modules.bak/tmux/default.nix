{ inputs, lib, ... }:
{
  flake.modules.homeManager.base =
    { config, pkgs, ... }:
    let
      inherit (pkgs.stdenv) hostPlatform isDarwin;
      inherit (lib) optionals attrValues;
    in
    {
      home = {
        packages =
          (attrValues {
            inherit (pkgs)
              tmux
              tmux-xpanes
              ;
            inherit (pkgs.tmuxPlugins)
              battery
              copycat
              cpu
              open
              prefix-highlight
              resurrect
              ;
          })
          ++ optionals isDarwin (attrValues {
            inherit (pkgs)
              reattach-to-user-namespace
              ;
          });
      };
      xdg.configFile = {
        "tmux/tmux.conf".source = pkgs.replaceVars ./tmux.conf {
          tmux_config_dir = "${config.xdg.configHome}/tmux";
          battery = "${pkgs.tmuxPlugins.battery}";
          copycat = "${pkgs.tmuxPlugins.copycat}";
          cpu = "${pkgs.tmuxPlugins.cpu}";
          open = "${pkgs.tmuxPlugins.open}";
          prefix_highlight = "${pkgs.tmuxPlugins.prefix-highlight}";
          resurrect = "${pkgs.tmuxPlugins.resurrect}";
          catppuccin = "${inputs.catppuccin.packages.${hostPlatform.system}.tmux}";
        };
        "tmux/clipboard-copy.sh" = {
          source = ./clipboard-copy.sh;
        };
      };
    };
}
