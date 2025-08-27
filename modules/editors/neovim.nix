{ lib, ... }:
{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      home.packages = lib.attrValues {
        inherit (pkgs.luajitPackages) luarocks;

        inherit (pkgs.nodePackages_latest) nodejs;

        inherit (pkgs)
          # Body
          neovim

          # Dependency
          sqlite
          tree-sitter
          uv

          # Language servers
          bash-language-server
          clang-tools
          # cmake-language-server
          copilot-language-server
          deno # builtin server/formatter
          efm-langserver
          fortls
          lua-language-server
          marksman
          nixd
          nixf-diagnose
          ruff # builtin server/formatter
          taplo
          texlab
          typescript-language-server
          vscode-langservers-extracted
          vtsls
          yaml-language-server

          # Linters
          cmake-lint
          markdownlint-cli2
          shellcheck
          statix
          # vim-vint

          # Formatters
          beautysh
          biome
          cmake-format
          eslint_d
          github-markdown-toc-go
          nixfmt-rfc-style
          prettierd
          shfmt
          sql-formatter
          stylua
          treefmt
          ;
      };

      home.sessionVariables = {
        LIBSQLITE = "${pkgs.sqlite.out}/lib/libsqlite3${pkgs.stdenv.hostPlatform.extensions.sharedLibrary}";
      };
    };

  nixpkgs.allowUnfreePackages = [
    "copilot-language-server"
  ];
}
