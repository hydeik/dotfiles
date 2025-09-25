{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        # Language server
        marksman
        # Linter / Fomatter
        github-markdown-toc-go
        markdownlint-cli2
        # Tools
        glow
      ];
    };
}
