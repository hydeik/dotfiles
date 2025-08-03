{ lib, ... }:
{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      home.packages = lib.attrValues {
        inherit (pkgs.luajitPackages) luarocks;

        inherit (pkgs.nodePackages_latest) nodejs;

        inherit (pkgs)
          # Dependency
          # sqlite
          uv

          # Language servers
          bash-language-server
          clang-tools
          cmake-language-server
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
          vim-vint

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

      programs.neovim = {
        enable = true;
        extraPackages = with pkgs; [
          sqlite
        ];
        extraWrapperArgs = [
          "--prefix"
          "LD_LIBRARY_PATH"
          ":"
          "${pkgs.sqlite}/lib"
        ];
      };
    };

  nixpkgs.allowUnfreePackages = [
    "copilot-language-server"
  ];
}
