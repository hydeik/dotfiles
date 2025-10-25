{ config, ... }:
{
  flake.modules.homeManager.base = {
    programs = {
      git = {
        enable = true;
        settings = {
          user = {
            inherit (config.flake.meta.owner) name;
            email = config.flake.meta.owner.name;
          };
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
