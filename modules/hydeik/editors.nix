{ inputs, __findFile, ... }:
let
  flake-file.inputs = {
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
      };
    };

    vim-overlay = {
      url = "github:kawarimidoll/vim-overlay";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        pre-commit-hooks.follows = "git-hooks";
      };
    };
  };

  overlays = [
    inputs.neovim-nightly-overlay.overlays.default
    (inputs.vim-overlay.overlays.features {
      cscope = true;
      lua = true;
      python3 = true;
      ruby = true;
      sodium = true;
    })
  ];

  hydeik.editors = {
    includes = [
      (<den/unfree> [
        "cursor"
        "vscode"
      ])
    ];

    homeManager =
      { pkgs, ... }:
      {
        imports = [
          { nixpkgs.overlays = overlays; }
        ];

        home.packages = [
          pkgs.helix
          pkgs.code-cursor
          # pkgs.zed-editor
          pkgs.vscode
          # NeoVim & dependencies
          pkgs.neovim
          pkgs.tree-sitter
          # Vim
          pkgs.vim
        ];
      };
  };
in
{
  inherit flake-file hydeik;
}
