{
  hydeik.dev-lang = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          # Language server
          # TODO: temporarily disable marksman due to swift build error.
          # marksman
          markdown-oxide
          # Linter / Fomatter
          github-markdown-toc-go
          markdownlint-cli2
          # Tools
          glow
        ];
      };
  };
}
