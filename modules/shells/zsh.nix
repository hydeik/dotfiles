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

      xdg.configFile = {
        zsh = {
          recursive = true;
          source = ./zsh;
          onChange = ''
            # Remove old cache/zwc files
            rm -rf ${zdotdir}/.zshrc.zwc
            rm -rf ${zdotdir}/.zshenv.zwc
            rm -rf ${zdotdir}/*.zwc
            rm -rf ${zdotdir}/**/*.zwc
            rm -rf ${zdotdir}/sheldon/sheldon.zsh
            rm -rf ${zdotdir}/rc/10_direnv.zsh
          '';
        };
        # zsh-fast-syntax-highlighting
        fsh = {
          recursive = true;
          source = ./fsh;
        };
      };
    };
}
