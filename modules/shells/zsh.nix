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
            rm -rf ${config.xdg.configHome}/zsh/.zshrc.zwc
            rm -rf ${config.xdg.configHome}/zsh/.zshenv.zwc
            rm -rf ${config.xdg.configHome}/zsh/*.zwc
            rm -rf ${config.xdg.configHome}/zsh/**/*.zwc
            rm -rf ${config.xdg.configHome}/zsh/sheldon/sheldon.zsh
            rm -rf ${config.xdg.configHome}/zsh/rc/10_direnv.zsh
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
