{
  config,
  inputs,
  ...
}:
{
  flake.modules.darwin.desktop =
    let
      taps = {
        "homebrew/homebrew-core" = inputs.homebrew-core;
        "homebrew/homebrew-cask" = inputs.homebrew-cask;
      };
    in
    {
      imports = [ inputs.nix-homebrew.darwinModules.nix-homebrew ];
      config = {
        nix-homebrew = {
          enable = true;
          mutableTaps = false;
          inherit taps;
        };

        homebrew = {
          enable = true;
          global.autoUpdate = false;
          onActivation = {
            upgrade = true;
            # 'zap': uninstalls all formulae (and related files) not listed here.
            cleanup = "zap";
          };

          # If we don't do this, nix-darwin may attempt to remove our taps even
          # when they are managed by nix-homebrew.
          taps = builtins.attrNames taps;

          # `brew install --cask`
          casks = [
            "alacritty"
            "apache-directory-studio"
            "appcleaner"
            "aquaskk"
            "cog"
            "deepl"
            "discord"
            "dropbox"
            "firefox"
            "ghostty"
            "gimp"
            "google-chrome"
            "inkscape"
            "kap"
            "karabiner-elements"
            "keycastr"
            "nextcloud"
            "obs"
            "macskk"
            "mactex"
            "microsoft-auto-update"
            "microsoft-office"
            "microsoft-teams"
            "qmk-toolbox"
            "raycast"
            "slack"
            "temurin" # JDK
            "temurin@21"
            "vesta"
            "vial"
            "wezterm"
            "zoom"
            "zotero"
          ];

          # Apps in AppStore
          #
          # FIXME:
          # nix-darwin reinstall masApps upon darwin-rebuild due to the
          # following issues (temporarily install these apps manually).
          #
          # - https://github.com/nix-darwin/nix-darwin/issues/1323
          # - https://github.com/mas-cli/mas/issues/724
          #
          # masApps = {
          #   # Security
          #   "Bitwarden" = 1352778147;
          #
          #   # Utility
          #   "The Unarchiver" = 425424353;
          #
          #   # Communication tools
          #   "LINE" = 539883307;
          #   "WhatsApp Messenger" = 310633997;
          # };
        };
      };

    };
}
