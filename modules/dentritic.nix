{ inputs, lib, ... }:
{
  imports = [
    (inputs.flake-parts.flakeModules.modules or { })
    (inputs.flake-aspects.flakeModule or { })
    (inputs.den.flakeModule or { })
  ];

  systems = lib.mkDefault (import inputs.systems);
}
