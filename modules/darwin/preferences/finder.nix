{
  flake.modules.darwin.desktop = {
    system.defaults = {
      finder = {
        # show the POSIX fullpath in the window title.
        _FXShowPosixPathInTitle = true;

        # show all file extensions
        AppleShowAllExtensions = true;

        # show hidden files
        AppleShowAllFiles = true;

        # disable warning when changing file extension
        FXEnableExtensionChangeWarning = false;

        # show path breadcrumbs
        ShowPathbar = true;

        # show status bar
        ShowStatusBar = true;
      };
    };
  };
}
