{ inputs, ... }:
{
  flake-file.inputs.git-hooks = {
    url = "github:cachix/git-hooks.nix";
    inputs = {
      # flake-compat.follows = "flake-compat";
      gitignore.follows = "";
      nixpkgs.follows = "nixpkgs";
    };
  };

  imports = [
    inputs.git-hooks.flakeModule
  ];

  perSystem =
    { config, ... }:
    {
      devshells.default.devshell.startup.git-hooks.text = config.pre-commit.installationScript;
      pre-commit.check.enable = false;
    };
}
