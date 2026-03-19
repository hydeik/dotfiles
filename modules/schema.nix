{ lib, ... }:
{
  den.schema.user = {
    config.classes = lib.mkDefault [ "homeManager" ];
  };
}
