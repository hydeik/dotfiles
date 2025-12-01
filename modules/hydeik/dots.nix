{
  hydeik.dots = {
    homeManager =
      { config, pkgs, ... }:
      let
        inherit (config.xdg)
          cacheHome
          configHome
          dataHome
          ;

        dotsDir = "${config.home.homeDirectory}/src/github.com/hydeik/dotfiles/dots";

        dotsLink = path: config.lib.file.mkOutOfStoreSymlink "${dotsDir}/${path}";

        zshSources = [
          ".zshenv"
          ".zshrc"
          "p10k.zsh"
          "completions/_pip"
          "completions/_pipenv"
          "functions/fzf-cd-ghq-repo"
          "functions/fzf-cdr"
          "functions/ranger-cd"
          "rc/10_functions.zsh"
          "rc/20_autoload.zsh"
          "rc/30_options.zsh"
          "rc/40_zstyle.zsh"
          "rc/50_completions.zsh"
          "rc/50_variables.zsh"
          "rc/60_alias.zsh"
          "rc/70_keybindings.zsh"
          "scripts/executable_24-bit-color.sh"
          "scripts/executable_sort_timings.zsh"
          "scripts/tmux_auto.zsh"
          "sheldon/plugins.toml"
        ];
      in
      {
        xdg.enable = true;
        xdg.configFile = {
          "alacritty/alactitty.toml".source = dotsLink "config/alacritty/alacritty.toml";
          "alacritty/themes".source = dotsLink "config/alacritty/themes";
          "alacritty/fonts".source = dotsLink "config/alacritty/fonts";
          "npm/npmrc".source = dotsLink "config/npm/npmrc";
          "nvim".source = dotsLink "config/nvim";
          "python/pythonstartup.py".source = dotsLink "config/python/pythonstartup.py";
          # fast-syntax-highlighting
          "fsh".source = dotsLink "config/fsh";
        }
        // builtins.foldl' (
          acc: name:
          acc
          // {
            "zsh/${name}" = {
              source = dotsLink "config/zsh/${name}";
            };
          }
        ) { } zshSources;
      };
  };
}
