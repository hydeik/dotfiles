{ lib, ... }:
{
  hydeik.tmux.homeManager =
    { pkgs, ... }:
    let
      inherit (pkgs.stdenv) isDarwin;
      inherit (lib) optionals attrValues;
    in
    {
      home = {
        packages =
          (attrValues {
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
          ++ optionals isDarwin (attrValues {
            inherit (pkgs)
              reattach-to-user-namespace
              ;
          });
      };
    };
}
