{
  flake.modules.darwin.desktop = {
    system.defaults = {
      trackpad = {
        # Enable tap to click
        Clicking = true;

        # Enable two finger right click
        TrackpadRightClick = true;

        # Enable three finger drag
        TrackpadThreeFingerDrag = true;
      };
    };
  };
}
