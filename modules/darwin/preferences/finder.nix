{
  flake.modules.darwin.desktop = {
    systems.defaults = {
      finder = {
        # show the POSIX fullpath in the window title.
        _FXShowPosixPathInTitle = true;

        # show all file extensions
        AppleShowAllExtensions = true;

        # show hidden files
        AppleShowAllFiles = true;

        # disable warning when changing file extension
        FXEnableExtensionChangeWarining = false;

        # show path breadcrumbs
        ShowPathbar = true;

        # show status bar
        ShowStatusBar = true;
      };
    };
  };
}
