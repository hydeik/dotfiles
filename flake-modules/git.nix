{ config, ... }:
{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
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
            init.defaultBranch = "main";
            push.useForceIfIncludes = true;
          };
          ignores = [
            ".DS_Store"
            ".direnv"
            ".ipynb_checkpoints"
            ".vscode/"
            ".worktree"
            "__pycache__/"
          ];
        };
      };
    };
}
