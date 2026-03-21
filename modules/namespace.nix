{ inputs, den, ... }:
{
  # Enable the angle bracket syntax for deep apsect lookup.
  _module.args.__findFile = den.lib.__findFile;

  # Set namespaces for aspects
  imports = [
    # namespace for host specific settings
    (inputs.den.namespace "hydix" false)
    # namespace for common user settings
    (inputs.den.namespace "hydeik" false)
  ];

  flake.den = den; # TODO: remove after debugging
}
