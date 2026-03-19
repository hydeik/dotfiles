{ den, ... }:
{
  den.default = {
    nixos.system.stateVersion = "25.11";
    homeManager.home.stateVersion = "25.11";
    darwin.system.stateVersion = 6;

    includes = [
      den.provides.define-user
      den.provides.hostname
      den.provides.inputs'
    ];
  };
}
