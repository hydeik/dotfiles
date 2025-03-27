{
  flake.modules.homeManager = {
    gui =
      { config, ... }:
      {
        programs = {
          alacritty = {
            enable = true;
            settings = {
              bell = {
                animation = "EaseOutExpo";
                duration = config.style.bellDuration;
              };
              colors = {
                draw_bold_text_with_bright_colors = true;
                transparent_background_colors = true;
              };
              env = {
                COLORTERM = "truecolor";
              };
              font = {
                normal = {
                  family = "PlemolJP35 Console NF";
                  style = "Text";
                };
                bold.style = "Bold";
                bold_italic.style = "Bold Italic";
                italic.style = "Text Italic";
                size = 14.0;
              };
              selection = {
                save_to_clipboard = true;
              };
              window = {
                opacity = config.style.windowOpacity;
                padding = {
                  x = 5;
                  y = 5;
                };
                startup_mode = "Maximized";
              };
            };
          };
        };
      };
  };
}
