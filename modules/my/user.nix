# This module configures my user over all my hosts.
{ __findFile, ... }:
{
  my.user = <den.lib.parametric> {
    includes = [
      <den/primary-user>

      <hydix/nix-index>
      <hydix/nix-registry>

      <hydeik/ai>
      <hydeik/catppuccin>
      <hydeik/cli-tui>
      <hydeik/dev-lang>
      <hydeik/direnv>
      <hydeik/dots>
      <hydeik/editors>
      <hydeik/fonts>
      <hydeik/git>
      <hydeik/hm-backup>
      <hydeik/homebrew>
      <hydeik/jujutsu>
      <hydeik/nix-btw>
      <hydeik/secrets>
      <hydeik/shells>
      # <hydeik/skk>
      <hydeik/terminals>
      <hydeik/tmux>
      <hydeik/unfree>
    ];
  };
}
