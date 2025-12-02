{
  hydeik.dev-lang = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          # LSP
          bash-language-server
          # Linter
          shellcheck
          # Formatter
          shfmt
        ];
      };
  };
}
