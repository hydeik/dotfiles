{ config, lib, ... }:
{
  # Create custom namespece
  den.aspects.hydeik = { };
  # Expose aspect-tree to public
  flake.hydiek = config.den.aspects.hydeik.provides;
  # Easy access to modules
  _module.args.hydeik = config.den.aspects.hydeik.provides;
  # Write directly to hydeik attributes
  imports = [
    (lib.mkAliasOptionModule [ "hydeik" ] [ "den" "aspects" "hydeik" "provides" ])
  ];
}
