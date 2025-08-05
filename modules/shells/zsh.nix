_: {
  flake.modules.homeManager.base =
    { config, pkgs, ... }:
    let
      zdotdir = "${config.xdg.configHome}/zsh";
    in
    {
      home.packages = with pkgs; [
        zsh
        deno
        fzf
        sheldon
      ];

      home.file.".zshenv".text = ''
        ##
        ## File ~/.zshenv
        ##
        export ZDOTDIR="${zdotdir}"
        source "''\${ZDOTDIR}/.zshenv"
      '';
    };
}
