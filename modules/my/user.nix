# This module configures my user over all my hosts.
{ __findFile, ... }:
{
  my.user = <den.lib.parametric> {
    includes = [
      <hydix/nix-index>
      <hydix/nix-registry>

      <hydeik/catppuccin>
      <hydeik/cli-tui>
      <hydeik/direnv>
      <hydeik/editors>
      <hydeik/fonts>
      <hydeik/git>
      <hydeik/nix-btw>
      <hydeik/shells>
      <hydeik/terminals>
      <hydeik/tmux>
    ];
  };
}
