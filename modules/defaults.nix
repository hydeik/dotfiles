{ __findFile, ... }:
{
  den.default.includes = [
    <den/define-user>
    <hydix/hostname>
    <my/nix-settings>
    <my/state-version>
  ];
}
