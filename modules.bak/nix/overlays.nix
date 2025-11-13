{
  inputs,
  lib,
  ...
}:
{
  options.nix.nixpkgs = lib.mkOption {
    type = lib.types.lazyAttrsOf lib.types.anything;
  };

  config = {
    nix.nixpkgs.overlays = [
      inputs.neovim-nightly-overlay.overlays.default
      (inputs.vim-overlay.overlays.features {
        cscope = true;
        lua = true;
        python3 = true;
        ruby = true;
        sodium = true;
      })
    ];
  };
}
