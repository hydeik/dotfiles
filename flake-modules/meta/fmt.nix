{ inputs, ... }:
{
  imports = [ inputs.treefmt-nix.flakeModule ];
  perSystem =
    { pkgs, ... }:
    {
      treefmt = {
        projectRootFile = "flake.nix";

        programs = {
          biome.enable = true;
          deadnix.enable = true;
          just.enable = true;
          nixfmt = {
            enable = true;
            package = pkgs.nixfmt-rfc-style;
          };
          shellcheck.enable = true;
          shfmt.enable = true;
          statix.enable = true;
          stylua.enable = true;
          taplo.enable = true;
          yamlfmt.enable = true;
        };

        settings = {
          on-unmatched = "fatal";
          global.excludes = [
            "*.conf"
            "*.md"
            "*.zsh"
            "*/.gitignore"
            "*/.gitkeep"
            "LICENSE"
            ".editorconfig"
          ];
        };
      };

      pre-commit.settings.hooks.nix-fmt = {
        enable = true;
        entry = "nix fmt -- --fail-on-change";
      };
    };
}
