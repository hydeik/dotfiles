{ inputs, lib, ... }:
{
  imports = [
    inputs.flake-parts.flakeModules.modules
    inputs.flake-aspects.flakeModule
    inputs.den.flakeModule
  ];

  systems = lib.mkDefault (import inputs.systems);
}
