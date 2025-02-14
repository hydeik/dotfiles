{
  description = "Hidekazu Ikeno (hydeik)'s dotfile powered by Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";

    ez-configs.url = "github:ehllie/ez-configs";
    ez-configs.inputs.nixpkgs.follows = "nixpkgs";
    ez-configs.inputs.flake-parts.follows = "flake-parts";

    # git-hooks.url = "github:hercules-ci/flake-parts";
    # git-hooks.inputs.gitignore.follows = "";
    # git-hooks.inputs.nixpkgs.follows = "nixpkgs";
    # git-hooks.inputs.nixpkgs-stable.follows = "nixpkgs";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    neovim-nightly-overlay.inputs.flake-parts.follows = "flake-parts";
    # neovim-nightly-overlay.inputs.git-hooks.follows = "git-hooks";
    neovim-nightly-overlay.inputs.nixpkgs.follows = "nixpkgs";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, flake-parts, ... }@inputs: flake-parts.lib.mkFlake
    { inherit inputs; }
    {
      imports = [
        inputs.ez-configs.flakeModule
      ];

      systems = [
        "aarch64-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];

      ezConfigs = {
        root = ./.;
        globalArgs = { inherit inputs; };
        home.users = {
          root = {
            importDefault = false;
          };
        };
      };

      perSystem = { config, pkgs, system, ... }: {
        _module.args.pkgs = import self.inputs.nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

        devShells = {
          default = pkgs.mkShell {
            name = "default-shell";
            packages = with pkgs; [
              age
              nix-fast-build
              sops
              ssh-to-age
            ];
          };
        };
      };

    };

}
