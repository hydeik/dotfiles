{ inputs, ... }:
let
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
in
{
  flake.modules.darwin.desktop = {
    nixpkgs.overlays = overlays;
  };

  flake.modules.nixos.desktop = {
    nixpkgs.overlays = overlays;
  };
}
