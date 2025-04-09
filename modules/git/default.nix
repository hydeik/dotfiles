{ config, ... }:
{
  flake.modules.homeManager.base = {
    programs = {
      git = {
        enable = true;
        userName = config.flake.meta.owner.name;
        userEmail = config.flake.meta.owner.name;
        delta = {
          enable = true;
          options = {
            line-numbers = true;
            navigate = true;
            side-by-side = true;
          };
        };
        extraConfig = {
          diff.algorithm = "histogram";
          init.defaultBranch = "main";
          merge.conflictstyle = "zdiff3";
          push.useForceIfIncludes = true;
          rerere.enable = true;
          safe.bareRepository = "explicit";
        };
        ignores = [
          ".DS_Store"
          ".ipynb_checkpoints"
          ".vscode/"
          ".worktree"
          "__pycache__/"
        ];
      };
    };
  };
}
