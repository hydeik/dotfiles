{ inputs, ... }:
{
  flake-file.inputs = {
    nix-index-database.url = "github:nix-community/nix-index-database";
  };

  flake.modules.homeManager.nix-index = {
    imports = [
      inputs.nix-index-database.homeModules.nix-index
    ];

    programs.nix-index.enable = true;
    # optional to also wrap and install comma
    programs.nix-index-database.comma.enable = true;
  };
}
