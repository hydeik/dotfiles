{ inputs, den, ... }:
{
  _module.args.__findFile = den.lib.__findFile;
  imports = [
    (inputs.den.namespace "hydeik" true)
    (inputs.den.namespace "my" false)
  ];
}
