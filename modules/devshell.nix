{ inputs, lib, ... }:
{
  flake-file.inputs.devshell = {
    url = lib.mkDefault "github:numtide/devshell";
    inputs.nixpkgs.follows = lib.mkDefault "nixpkgs";
  };

  imports = [
    inputs.devshell.flakeModule
  ];

  perSystem =
    { pkgs, ... }:
    {
      devshells.default = {
        commands = [
          {
            name = "fmt";
            command = "nix fmt";
          }
          {
            name = "write-flake";
            command = "nix run .#write-flake";
          }
        ];
        packages = with pkgs; [
          bat
          biome
          deadnix
          gnupg
          lua-language-server
          nixd
          nixfmt-rfc-style
          ripgrep
          shellcheck
          shfmt
          sops
          ssh-to-age
          statix
          stylua
          taplo
          vim
          yamlfmt
        ];
      };
    };
}
