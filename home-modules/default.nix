{ ezModules, lib, inputs, ... }:
{
  imports = lib.attrValues
    {
      inherit(ezModules)
        xdg
        ;
    };
}
