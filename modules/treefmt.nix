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
          nixfmt = {
            enable = true;
            package = pkgs.nixfmt-rfc-style;
          };
          statix.enable = true;
        };

        settings = {
          on-unmatched = lib.mkDefault "fatal";
          global.excludes = [
            "*.bak"
            "modules/*"
            "modules.bak/*"
            "dots/*"
            "*.yaml"
            "*.toml"
            "*.conf"
            "*.md"
            "*.yml"
            "*/.gitignore"
            "*/.gitkeep"
            "*/fsh/*"
            "*/zsh/*"
            "*.zsh"
            "LICENSE"
            "*/npmrc"
            "*/pythonstartup.py"
            ".editorconfig"
            "*/.editorconfig"
            ".direnv/*"
            "*/lazy-lock.json"
          ];
        };
      };

      pre-commit.settings.hooks.treefmt.enable = true;
    };
}
