{ lib, ... }:
{
  hydeik.dots = {
    homeManager =
      { config, pkgs, ... }:
      let
        inherit (pkgs.stdenv) isDarwin;
        inherit (lib) optionalAttrs;

        dotsDir = "${config.home.homeDirectory}/src/github.com/hydeik/dotfiles/dots";

        dotsLink = p: config.lib.file.mkOutOfStoreSymlink "${dotsDir}/${p}";

        zshSources = [
          ".zshenv"
          ".zshrc"
          "p10k.zsh"
          "completions/_pip"
          "completions/_pipenv"
          "functions/fzf-cd-ghq-repo"
          "functions/fzf-cdr"
          "functions/ranger-cd"
          "rc/10_direnv.zsh"
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

        home.file.".editorconfig".source = dotsLink ".editorconfig";

        xdg.configFile = {
          "starship.toml".source = dotsLink "config/starship.toml";
          "alacritty/alacritty.toml".source = dotsLink "config/alacritty/alacritty.toml";
          "alacritty/themes".source = dotsLink "config/alacritty/themes";
          "alacritty/fonts".source = dotsLink "config/alacritty/fonts";
          "ghostty/config".source = dotsLink "config/ghostty/config";
          "ghostty/fonts".source = dotsLink "config/ghostty/fonts";
          "ghostty/keybind.conf".source = dotsLink "config/ghostty/keybind.conf";
          "npm/npmrc".source = dotsLink "config/npm/npmrc";
          "nushell/config.nu".source = dotsLink "config/nushell/config.nu";
          "nushell/env.nu".source = dotsLink "config/nushell/env.nu";
          "nvim".source = dotsLink "config/nvim";
          "python/pythonstartup.py".source = dotsLink "config/python/pythonstartup.py";
          "television/cable/ghq.toml".source = dotsLink "config/television/cable/ghq.toml";
          "tmux".source = dotsLink "config/tmux";
          "wezterm".source = dotsLink "config/wezterm";
          # fast-syntax-highlighting
          "fsh".source = dotsLink "config/fsh";
        }
        // optionalAttrs isDarwin {
          "ghostty/macos.conf".source = dotsLink "config/ghostty/macos.conf";
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
