{
  hydeik.shells.homeManager =
    { config, pkgs, ... }:
    let
      zdotdir = "${config.xdg.configHome}/zsh";
    in
    {
      home.packages = with pkgs; [
        zsh
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
