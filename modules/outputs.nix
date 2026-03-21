{ lib, ... }:
{
  #
  # flake-parts does not provide built-in merge sematnic for
  # darwinConfigurations/homeConfigurations, so we need define the following options
  #
  # See https://github.com/vic/den/discussions/317
  #
  options.flake = {
    darwinConfigurations = lib.mkOption {
      default = { };
      type = lib.types.lazyAttrsOf lib.types.raw;
    };
    homeConfigurations = lib.mkOption {
      default = { };
      type = lib.types.lazyAttrsOf lib.types.raw;
    };
  };
}
