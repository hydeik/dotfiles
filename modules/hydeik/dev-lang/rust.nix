{
  hydeik.dev-lang = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          cargo
          cargo-watch
          cargo-outdated
          cargo-feature
          rustfmt
          rustup
        ];
      };
  };
}
