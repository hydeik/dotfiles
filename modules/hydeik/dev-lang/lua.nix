{
  hydeik.dev-lang = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          # Language servers
          lua-language-server
          emmylua-ls
          # Linters
          emmylua-check
          # Formatters
          stylua
          # Document generation tool
          emmylua-doc-cli
        ];
      };
  };
}
