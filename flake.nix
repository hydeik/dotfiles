{
  description = "Hidekazu Ikeno (hydeik)'s dotfile powered by Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";

    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";

    git-hooks.url = "github:hercules-ci/flake-parts";
    git-hooks.inputs.gitignore.follows = "";
    git-hooks.inputs.nixpkgs.follows = "nixpkgs";
    git-hooks.inputs.nixpkgs-stable.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    neovim-nightly-overlay.inputs.flake-parts.follows = "flake-parts";
    neovim-nightly-overlay.inputs.git-hooks.follows = "git-hooks";
    neovim-nightly-overlay.inputs.nixpkgs.follows = "nixpkgs";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, flake-pars, nix-darwin, nixpkgs, ... }:
  # let
  #   configuration = { pkgs, ... }: {
  #     # List packages installed in system profile. To search by name, run:
  #     # $ nix-env -qaP | grep wget
  #     environment.systemPackages =
  #       [ pkgs.vim
  #       ];
  #
  #     # Necessary for using flakes on this system.
  #     nix.settings.experimental-features = "nix-command flakes";
  #
  #     # Enable alternative shell support in nix-darwin.
  #     # programs.fish.enable = true;
  #
  #     # Set Git commit hash for darwin-version.
  #     system.configurationRevision = self.rev or self.dirtyRev or null;
  #
  #     # Used for backwards compatibility, please read the changelog before changing.
  #     # $ darwin-rebuild changelog
  #     system.stateVersion = 5;
  #
  #     # The platform the configuration will be used on.
  #     nixpkgs.hostPlatform = "aarch64-darwin";
  #   };
  # in
  flake-parts.lib.mkFlake { inherit inputs; } {
    imports = [
      inputs.git-hooks.flakeModule
      inputs.treefmt-nix.flakeModule
    ];

    systems = [
      # systems for which you want to build the `perSystem` attributes
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];

    perSystem = { config, pkgs, system, ... }: {
      # This sets `pkgs` to a nixpkgs with allowUnfree option set.
      _module.args.pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      # Configure pre-commit hooks
      pre-commit = {
        # Perform the pre-commit checks in `nix flake check`.
        check.enable = true;
        # The `git-hooks.nix` configuration
        settings = {
          src = ./.;
          hooks = {
            # keep-sorted start
            check-json.enable = true;
            check-toml.enable = true;
            deadnix.enable = true;
            flake-checker.enable = true;
            lua-ls.enable = false;
            nil.enable = true;
            shellcheck.enable = true;
            statix.enable = true;
            treefmt.enable = true;
            yamllint.enable = true;
            # keep-sorted end
          };
        };
      };

      treefmt = {
        projectRootFile = "flake.nix";
        programs = {
          # keep-sorted start
          deno.enable = true;
          keep-sorted.enable = true;
          nixfmt.enable = true;
          shfmt.enable = true;
          stylua.enable = true;
          taplo.enable = true;
          yamlfmt.enable = true;
          # keep-sorted end
        };
      };
    };

    flake = {
      # Put your original flake attributes here.
    };

    # # Build darwin flake using:
    # # $ darwin-rebuild build --flake .#simple
    # darwinConfigurations."simple" = nix-darwin.lib.darwinSystem {
    #   modules = [ configuration ];
    # };
  };
}
