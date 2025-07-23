{ inputs, ... }:
{
  imports = [
    inputs.flake-file.flakeModules.dendritic
  ];

  flake-file.inputs = {
    falke-file.url = "github:vic/flake-file";
  };
}
