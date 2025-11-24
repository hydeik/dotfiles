# This module configures my user over all my hosts.
{ __findFile, ... }:
{
  my.user = <den.lib.parametric> {
    includes = [
      <den/primary-user>
      <hydix/nix-index>
      <hydix/nix-registry>

      <hydeik/direnv>
      <hydeik/editors>
      <hydeik/fonts>
      <hydeik/git>
    ];
  };
}
