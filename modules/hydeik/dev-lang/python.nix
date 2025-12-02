{
  hydeik.dev-lang = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          # Package manager
          pixi
          pixi-pack
          uv
          uv-sort
          # Language server / Linter / Formatter
          ruff
        ];
      };
  };
}
