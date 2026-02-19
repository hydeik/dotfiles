{ inputs, lib, ... }:
{
  flake-file.inputs = {
    devshell = {
      url = lib.mkDefault "github:numtide/devshell";
      inputs.nixpkgs.follows = lib.mkDefault "nixpkgs";
    };
    flake-compat = {
      url = "github:NixOS/flake-compat";
      flake = false;
    };
  };

  imports = [
    inputs.devshell.flakeModule
  ];

  perSystem =
    { pkgs, ... }:
    {
      devshells = {
        default = {
          imports = [
            "${inputs.devshell}/extra/language/rust.nix"
          ];
          language.rust = {
            enableDefaultToolchain = true;
          };
          devshell.packages = with pkgs; [
            age
            bat
            deadnix
            gnupg
            lua-language-server
            nixd
            nixfmt
            ripgrep
            shellcheck
            shfmt
            sops
            ssh-to-age
            statix
            stylua
            taplo
            yamlfmt
            libiconv
            apple-sdk
          ];
        };
      };
    };
}
