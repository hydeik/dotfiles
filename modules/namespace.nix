{ inputs, den, ... }:
{
  _module.args.__findFile = den.lib.__findFile;
  imports = [
    (inputs.den.namespace "hydix" false)
    (inputs.den.namespace "hydeik" false)
    (inputs.den.namespace "my" false)
  ];
}
