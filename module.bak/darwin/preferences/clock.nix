{
  flake.modules.darwin.desktop = {
    system.defaults = {
      # Use 24 hour time
      NSGlobalDomain.AppleICUForce24HourTime = false;

      menuExtraClock = {
        # Show a 24-hour clock, instead of a 12-hour clock.
        Show24Hour = true;

        # Show digital clock
        IsAnalog = false;

        # Show the clock with second precision, instead of minutes.
        ShowSeconds = true;
      };
    };
  };
}
