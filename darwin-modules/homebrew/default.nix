{ ... }: {
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      # cleanup = "zap";
    };
    # homebrew cask
    casks = [
      "alacritty"
      "apache-directory-studio"
      "appcleaner"
      "cog"
      "deepl"
      "discord"
      "dropbox"
      "firefox"
      "karabiner-elements"
      "nextcloud"
      "obs"
      "google-chrome"
      "microsoft-teams"
      "qmk-toolbox"
      "raycast"
      "slack"
      "vesta"
      "vial"
      "zoom"
      "zotero"
    ];
    # Apps in AppStore
    masApps = {
      # Microsoft Office
      "Microsoft OneNote" = 784801555;
      "Microsoft Outlook" = 985367838;
      "Microsoft Word" = 462054704;
      "Microsoft Excel" = 462058435;
      "Microsoft PowerPoint" = 462062816;
      "OneDrive" = 823766827;

      # Security
      "Bitwarden" = 1352778147;

      # Note
      "Notability: Notes, PDF" = 360593530;

      # Communication tools
      "LINE" = 539883307;
      "WhatsApp Messenger" = 310633997;
    };
  };
}

