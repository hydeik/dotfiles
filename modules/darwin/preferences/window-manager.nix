{
  flake.modules.darwin.desktop = {
    system.defaults.CustomUserPreferences = {
      "com.apple.WindowManager" = {
        # Click wallpaper to reveal desktop
        EnableStandardClickToShowDesktop = true;

        # Show items on desktop
        StandardHideDesktopIcons = false;

        # Do not hide items on desktop & stage manager
        HideDesktop = false;
        StageManagerHideWidgets = false;
        StandardHideWidgets = false;
      };
    };
  };
}
