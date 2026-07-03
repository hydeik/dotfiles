{ inputs, ... }:
{
  flake-file.inputs = {
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    # Optional: Declarative tap management
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
  };

  hydeik.homebrew =
    { user, ... }:
    {
      darwin =
        { config, ... }:
        {
          imports = [
            inputs.nix-homebrew.darwinModules.nix-homebrew
          ];

          nix-homebrew = {
            enable = true;
            mutableTaps = false;
            taps = {
              "homebrew/homebrew-core" = inputs.homebrew-core;
              "homebrew/homebrew-cask" = inputs.homebrew-cask;
            };
            user = user.userName;
          };

          environment = {
            variables = {
              # Do not send analytic data to Homebrew
              HOMEBREW_NO_ANALYTICS = "1";
              # Don't allow insecure redirects
              HOMEBREW_NO_INSECURE_REDIRECT = "1";
              # I don't need any hints because nix handles homebrew for me
              HOMEBREW_NO_ENV_HINTS = "0";
            };
            # Add homebrew to the PATH
            systemPath = [ "${config.homebrew.prefix}/bin" ];
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
            taps = builtins.attrNames config.nix-homebrew.taps;

            # `brew install --cask`
            casks = [
              "alacritty"
              "apache-directory-studio"
              "appcleaner"
              "aquaskk"
              "chatwork"
              "claude"
              # "cog-app"
              "deepl"
              "discord"
              "dropbox"
              "firefox"
              "ghostty"
              # "gimp"
              "google-chrome"
              # "inkscape"
              "kap"
              "karabiner-elements"
              "keycastr"
              "nextcloud"
              "obs"
              "macskk"
              # "mactex"
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
          };
        };
    };
}
