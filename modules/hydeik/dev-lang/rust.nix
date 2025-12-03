{
  hydeik.dev-lang = {
    homeManager =
      { config, pkgs, ... }:
      {
        home.packages = with pkgs; [
          cargo-watch
          cargo-outdated
          cargo-feature
          rustup
        ];

        home.sessionVariables = {
          RUSTUP_HOME = "${config.xdg.dataHome}/rustup";
          CARGO_HOME = "${config.xdg.dataHome}/cargo";
        };
      };
  };
}
