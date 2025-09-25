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
          nixfmt = {
            enable = true;
            package = pkgs.nixfmt-rfc-style;
          };
        };

        settings = {
          on-unmatched = "fatal";
          global.excludes = [
            "*.conf"
            "*.md"
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

      pre-commit.settings.hooks.nix-fmt = {
        enable = true;
        entry = "nix fmt -- --fail-on-change";
      };
    };
}
