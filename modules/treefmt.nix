{ inputs, lib, ... }:
{
  flake-file.inputs.treefmt-nix = {
    url = lib.mkDefault "github:numtide/treefmt-nix";
    inputs.nixpkgs.follows = lib.mkDefault "nixpkgs";
  };

  imports = [
    inputs.treefmt-nix.flakeModule
  ];

  perSystem =
    { pkgs, ... }:
    {
      treefmt = {
        projectRoot = inputs.flake-file;

        programs = {
          biome.enable = true;
          deadnix.enable = true;
          nixf-diagnose.enable = true;
          nixfmt.enable = true;
          shellcheck.enable = true;
          shfmt.enable = true;
          statix.enable = true;
        };
        settings = {
          on-unmatched = lib.mkDefault "fatal";
          global.excludes = [
            "*.bak"
            "modules/*"
            "dots/*"
            "*.conf"
            "*.md"
            "*.toml"
            "*.yaml"
            "*.yml"
            "*/.gitignore"
            "*/.gitkeep"
            "*/fsh/*"
            "*/zsh/*"
            "*.zsh"
            "LICENSE"
            ".editorconfig"
            "*/.editorconfig"
            ".direnv/*"
          ];
        };
      };

      pre-commit.settings.hooks.treefmt.enable = true;
    };
}
