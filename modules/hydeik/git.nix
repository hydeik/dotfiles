{
  hydeik.git.homeManager =
    { config, pkgs, ... }:
    {
      home.packages = with pkgs; [
        diffstatic
        ghq
      ];

      # Git
      programs.git = {
        enable = true;
        settings = {
          aliases = {
            "fap" = "fetch --all --prune";
            "recents" =
              "for-each-ref --sort=committerdate refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'";
          };
          core.editor = "vim";
          ghq.root = "${config.home.homeDirectory}/src";
          github.user = "hydeik";
          gitlab.user = "hydeik";
          init.defaultBranch = "main";
          pager.difftool = true;
          push.useForceIfIncludes = true;
          user = {
            name = "Hidekazu Ikeno";
            email = "hide.ikeno@gmail.com";
          };
        };
        ignores = [
          ".DS_Store"
          ".aider*"
          ".crush*"
          ".direnv"
          ".envrc"
          ".envrc.local"
          ".env"
          ".env.local"
          ".ipynb_checkpoints"
          ".pre-commit-config.yaml"
          ".vscode/"
          ".worktree"
          "__pycache__/"
          "*.swp"
          "*~"
        ];
        lfs.enable = true;
      };

      # Delta
      programs.delta = {
        enable = true;
        enableGitIntegration = true;
        options = {
          line-numbers = true;
          navigate = true;
          side-by-side = true;
        };
      };

      # Difftastic
      programs.difftastic = {
        enable = true;
        git.enable = true;
      };

      # GitHub CLI
      programs.gh.enable = true;

      # Lazygit
      programs.lazygit = {
        enable = true;
        settings = {
          git = {
            overrideGpg = true;
            pagers = [
              {
                colorArg = "always";
                pager = "delta --dark --paging=never";
              }
              {
                externalDiffCommand = "difft --color=always";
              }
            ];
          };
          gui = {
            nerdFontsVersion = "3";
          };
        };
      };
    };
}
