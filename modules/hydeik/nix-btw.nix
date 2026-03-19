{
  hydeik.nix-btw = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          nix-search-cli
          nixd # LSP server
          nixfmt
          cachix
          nix-inspect
          # nox  # TODO: tmporaliry disabled due to build error
        ];

        programs = {
          home-manager.enable = true;
          nh.enable = true;
        };
      };
  };
}
