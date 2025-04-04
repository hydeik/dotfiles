{
  config,
  inputs,
  ...
}:
{
  flake.modules.darwin.desktop = {
    imports = [ inputs.nix-homebrew.darwinModules.nix-homebrew ];
    config = {
      nix-homebrew = {
        enable = true;
        mutableTaps = false;
        taps = {
          "homebrew/homebrew-core" = inputs.homebrew-core;
          "homebrew/homebrew-cask" = inputs.homebrew-cask;
        };
      };

      homebrew = {
        enable = true;
        global.autoUpdate = false;
        onActivation = {
          upgrade = true;
          # 'zap': uninstalls all formulae (and related files) not listed here.
          cleanup = "zap";
        };

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
        masApps = {
          # Security
          "Bitwarden" = 1352778147;

          # Utility
          "The Unarchiver" = 425424353;

          # Communication tools
          "LINE" = 539883307;
          "WhatsApp Messenger" = 310633997;
        };
      };
    };

  };
}
