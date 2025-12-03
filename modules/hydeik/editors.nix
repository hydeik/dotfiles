{ __findFile, inputs, ... }:
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
    homeManager =
      { pkgs, ... }:
      {
        imports = [
          { nixpkgs.overlays = overlays; }
        ];

        home.packages = with pkgs; [
          helix
          code-cursor
          # zed-editor
          vscode
          # NeoVim & dependencies
          neovim
          tree-sitter
          # Vim
          vim
        ];
      };
  };
in
{
  inherit flake-file;
  inherit hydeik;
}
