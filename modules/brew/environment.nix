{
  flake.modules.darwin.desktop =
    { config, ... }:
    {
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
        systemPath = [ config.homebrew.brewPrefix ];
      };
    };
}
