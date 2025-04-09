{
  flake.modules.darwin.desktop = {
    system.defaults = {
      dock = {
        # display the appswitcher on all displays
        appswitcher-all-displays = true;

        # automatically show and hide the dock.
        autohide = true;

        # autohide animation duration
        autohide-delay = 0.0;

        # enable highlight hover effect for the grid view of a stack.
        mouse-over-hilite-stack = true;

        # disable recent spaces
        mru-spaces = false;

        # dock position
        orientation = "bottom";

        # disable showing recent applications
        show-recents = false;

        # make icons of hidden applications trancluent
        showhidden = true;

        # show only open applications
        static-only = true;
      };
    };
  };
}
