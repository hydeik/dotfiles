{
  hydeik.nix-btw = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          nix-search-cli
          nixd # LSP server
          cachix
          nix-inspect
          nox
        ];

        programs = {
          home-manager.enable = true;
          nh.enable = true;
        };
      };
  };
}
