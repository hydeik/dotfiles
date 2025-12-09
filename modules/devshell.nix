{ inputs, lib, ... }:
{
  flake-file.inputs = {
    make-shell = {
      url = lib.mkDefault "github:nicknovitski/make-shell";
      inputs.flake-compat.follows = lib.mkDefault "flake-compat";
    };
    flake-compat = {
      url = "github:NixOS/flake-compat";
      flake = false;
    };
  };

  imports = [
    inputs.make-shell.flakeModules.default
  ];

  perSystem =
    { pkgs, ... }:
    {
      make-shells.default = {
        packages = with pkgs; [
          bat
          biome
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
          vim
          yamlfmt
        ];
        nativeBuildInputs = [ pkgs.cargo ];
        buildInputs = [
          pkgs.pkg-config
          pkgs.libiconv
        ];
      };
    };
}
